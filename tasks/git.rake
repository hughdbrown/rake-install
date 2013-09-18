namespace :git do
  GIT_VERSION_STR = "1.8.3"

  desc "Install libgit2 library"
  task :libgit2 => ["dev:essential"] do
    FileUtils.cd(TMP_DIR) do
      sh("git clone git://github.com/libgit2/libgit2.git") unless Dir.exists?("libgit2")

      build_dir = "libgit2/build"
      FileUtils.mkdir(build_dir) unless Dir.exists?(build_dir)
      FileUtils.cd(build_dir) do
        sh("git pull")
        sh("cmake .. && cmake --build .")
      end
    end
  end

  desc "Install git binary"
  task :bin do
    test_fn = Proc.new {
      expect = /^git version #{GIT_VERSION_STR}$/
      (not command_exists("git")) || (`git --version`.strip.scan(expect).length == 0)
    }

    version = "git-#{GIT_VERSION_STR}"
    url = "https://git-core.googlecode.com/files/#{version}.tar.gz"
    install_tar(url, version, {:test => test_fn})
  end

  desc "Install git utilities"
  task :util do
    tools = %w{gitg gitk gitstats tig}
    install_pkg(tools)
  end
end

task :git => ["git:bin", "git:util", "git:libgit2"]
