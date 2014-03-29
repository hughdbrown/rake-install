namespace :rethinkdb do
  desc "Install rethinkdb"

  task :software_properties_common do
    install_pkg(["software-properties-common"])
  end

  task :rethinkdb => [:software_properties_common] do
    install_ppa("ppa:rethinkdb/ppa")
  end
end

