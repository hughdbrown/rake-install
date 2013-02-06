namespace :python do
  PYTHON_VERSION_STR = "3.3.0"

  task :pip do
    pkgs = %w{python-pip}
    install_pkg(pkgs)
    sh("sudo pip install virtualenv virtualenvwrapper")
  end

  #desc "Install python binary"
  task :cpython do
    test_fn = Proc.new {
      # Doesn't work -- python writes strign to strerr
      expect = "Python #{PYTHON_VERSION_STR}"
      (not command_exists("python3.3")) || (`python3.3 --version`.strip != expect)
    }

    version = "Python-#{PYTHON_VERSION_STR}"
    url = "http://python.org/ftp/python/#{PYTHON_VERSION_STR}/#{version}.tgz"
    install_tar(url, version, {:ext => "tgz", :test => test_fn})
  end

  #desc "Install pypy binary"
  task :pypy do
    pypy_version = "pypy-1.9"
    bzfile = "#{pypy_version}-linux.tar.bz2"

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
    #"python:cpython",
    "python:pypy"
]
