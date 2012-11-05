namespace :redis do
  desc "Install redis library"
  task :redis do
    version = "redis-2.6.0"
    url = "http://redis.googlecode.com/files/#{version}.tar.gz" 
    install_tar(url, version)
  end
end

desc "Install redis"
task :redis => ["redis:redis"]
