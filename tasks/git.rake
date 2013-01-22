namespace :git do
  #desc "Install libgit2 library"
  task :libgit2 => ["dev:essentials"] do
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

  #desc "Install git binary"
  task :bin do
    version = "git-1.8.0.2"
    url = "https://git-core.googlecode.com/files/#{version}.tar.gz"
    install_tar(url, version)
  end

  #desc "Install git utilities"
  task :util do
    tools = %w{gitg gitk gitstats tig}
    install_pkg(tools)
  end
end

task :git => ["git:bin", "git:util", "git:libgit2"]
