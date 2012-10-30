namespace :mongo do
  desc "Install mongo and tools"
  task :mongo do
    tools = %w{mongodb mongodb-server mongodb-dev mongodb-clients }
    install_pkg(tools)
  end

  desc "Latest mongo"
  task :mongo_latest => [:mongo] do
    version = "mongodb-linux-i686-2.2.0"
    url = "http://fastdl.mongodb.org/linux/#{version}.tgz"
    install_tar(url, version)
  end
end

task :mongo => ["mongo:mongo", "mongo:mongo_latest"]
