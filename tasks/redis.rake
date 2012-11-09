namespace :redis do
  #desc "Install redis library"
  task :redis do
    version = "redis-2.6.0"
    url = "http://redis.googlecode.com/files/#{version}.tar.gz" 
    b = Proc.new {
      FileUtils.cd("utils")
      sh("sudo ./install_server.sh")
    }
    install_tar(url, version, {:block => b})
  end
end

#desc "Install redis"
task :redis => ["redis:redis"]
