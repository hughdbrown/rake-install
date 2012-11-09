namespace :extra do

  #desc "Install libraries"
  task :libraries do
    tools = %w{libncurses5-dev libgdbm-dev}
    install_pkg(tools)
  end

  #desc "Install dpkg"
  task :dpkg do
    tools = %w{dpkg-dev}
    install_pkg(tools)
  end
end

#desc "Install extra stuff"
task :extra => ["extra:libraries", "extra:dpkg"]
