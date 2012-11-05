namespace :mongo do
  desc "Install mongo and tools"
  task :mongo do
    tools = %w{mongodb mongodb-server mongodb-dev mongodb-clients }
    install_pkg(tools)
  end

  desc "Latest mongo"
  task :mongo_latest => [:mongo] do
    version = "mongodb-linux-i686-2.2.1"
    url = "http://fastdl.mongodb.org/linux/#{version}.tgz"
    install_tar(url, version)
    FileUtils.cd(File.join(TMP_DIR, version, "bin")) do
      sh("sudo mv * /usr/bin/.")
    end
  end
end

task :mongo => ["mongo:mongo_latest"]
