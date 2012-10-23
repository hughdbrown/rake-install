namespace :redis do
  desc "Install redis library"
  task :redis do
    install_tar("http://redis.googlecode.com/files/redis-2.6.0.tar.gz", "redis-2.6.0")
  end
end

desc "Install redis"
task :redis => ["redis:redis"]
