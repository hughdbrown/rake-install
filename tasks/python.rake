namespace :python do
  #desc "Install python binary"
  task :cpython do
    version = "Python-3.3.0"
    url = "http://python.org/ftp/python/3.3.0/#{version}.tgz"
    install_tar(url, version, {:ext => "tgz"})
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
        elif ! File.exists?(dst)
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

task :python => ["python:cpython", "python:pypy"]
