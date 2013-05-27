namespace :rethinkdb do
  desc "Install rethinkdb"
  task :rethinkdb do
    install_ppa("ppa:rethinkdb/ppa")
  end
end

