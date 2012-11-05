namespace :git do
  desc "Install libgit2 library"
  task :libgit2 do
    FileUtils.cd(TMP_DIR) do
      if FileUtils.exists?("lib2git")
        sh("git pull")
      else
        sh("git clone git://github.com/libgit2/libgit2.git")
      end

      FileUtils.mkdir("libgit2/build") unless FileUtils.exists?("libgit2/build")
      FileUtils.cd("libgit2/build") do
        sh("cmake .. && cmake --build .")
      end
    end
  end

  desc "Install git binary"
  task :bin do
    #version = "git-1.7.12.3"
    version = "git-1.8.0"
    url = "https://git-core.googlecode.com/files/#{version}.tar.gz"
    install_tar(url, version)
  end

  desc "Install git utilities"
  task :util do
    tools = %w{gitg gitk gitstats tig}
    install_pkg(tools)
  end
end

task :git => ["git:bin", "git:util", "git:libgit2"]
