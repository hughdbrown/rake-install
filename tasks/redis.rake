namespace :redis do
  REDIS_VERSION_STR = "2.6.0"

  #desc "Install redis library"
  task :redis do
    version = "redis-#{REDIS_VERSION_STR}"
    url = "http://redis.googlecode.com/files/#{version}.tar.gz"
    
    test_fn = Proc.new {
      expect = /Redis server v=#{REDIS_VERSION_STR}.*/
      (not command_exists("redis-server")) || (not `redis-server --version`.strip.scan(expect))
    }
  
    b = Proc.new {
      FileUtils.cd("utils")
      sh("sudo ./install_server.sh")
    }
    install_tar(url, version, {:block => b, :test => test_fn})
  end
end

#desc "Install redis"
task :redis => ["redis:redis"]
