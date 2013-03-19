namespace :mongo do
  MONGO_VERSION_STR = "2.4.0"

  #desc "Install mongo and tools"
  task :mongo do
    tools = %w{mongodb mongodb-server mongodb-dev mongodb-clients }
    install_pkg(tools)
  end

  #desc "Latest mongo"
  task :bin do # => [:mongo] do
    version = "mongodb-linux-x86_64-#{MONGO_VERSION_STR}"
    url = "http://fastdl.mongodb.org/linux/#{version}.tgz"
    test_fn = Proc.new {
      expect = /MongoDB shell version: #{MONGO_VERSION_STR}/
      (not command_exists("mongo")) || (`mongo --version`.strip.scan(expect).length == 0)
    }

    b = Proc.new {
      FileUtils.cd(File.join(TMP_DIR, version, "bin")) do
        notice("Moving files to /usr/bin/")
        sh("sudo mv * /usr/bin/.")
      end
    }

    install_tar(url, version, {:block => b, :test => test_fn})
  end
end

task :mongo => ["mongo:bin"]
