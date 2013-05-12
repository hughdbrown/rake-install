namespace :python do
  PYTHON_VERSION_STR = "3.3.0"
  PYTHON_BIN = "python3.3"
  VERSION_CMD = "#{PYTHON_BIN} --version"
  EXPECTED_VERSION_STR = "Python #{PYTHON_VERSION_STR}"

  task :pip do
    pkgs = %w{python-pip}
    install_pkg(pkgs)
    sh("sudo pip install virtualenv virtualenvwrapper")
  end

  #desc "Install python binary"
  task :cpython do
    test_fn = Proc.new {
      # python writes string to strerr
      not (command_exists(PYTHON_BIN) && capture_stderr(VERSION_CMD)[0].strip == EXPECTED_VERSION_STR)
    }

    version = "Python-#{PYTHON_VERSION_STR}"
    url = "http://python.org/ftp/python/#{PYTHON_VERSION_STR}/#{version}.tgz"
    install_tar(url, version, {:ext => "tgz", :test => test_fn})
  end

  #desc "Install pypy binary"
  task :pypy do
    pypy_version = "pypy-2.0"
    #bzfile = "#{pypy_version}-linux.tar.bz2"
    bzfile = "#{pypy_version}-linux64.tar.bz2"

    FileUtils.cd(TMP_DIR) do
      begin
        sh("wget https://bitbucket.org/pypy/pypy/downloads/#{bzfile}")
        sh("tar xvfj #{bzfile}")

        verbose = {:verbose => true}
        dst = File.expand_path("~/bin/pypy")
        new_dir = File.expand_path("~/bin/pypy/#{pypy_version}")

        if File.exists?(new_dir)
          FileUtils.rm_rf(new_dir, verbose)
        elsif ! File.exists?(dst)
          FileUtils.mkdir_p(dst, verbose)
        end
        FileUtils.mv(pypy_version, dst, verbose)

        # Needs to run as sudo
        #FileUtils.ln_sf("#{dst}/#{pypy_version}/bin/pypy",
        #               "/usr/bin/",
        #               verbose)
        sh("sudo ln -sf #{dst}/#{pypy_version}/bin/pypy /usr/bin/")
      ensure
        FileUtils.rm(bzfile, verbose) if File.exists?(bzfile)
        FileUtils.rm_rf("#{pypy_version}", verbose) if File.exists?(pypy_version)
      end
    end
  end
end

task :python => [
    "python:cpython",
    "python:pypy"
]
