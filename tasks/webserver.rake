namespace :webserver do
  task :all => [:apache, :nginx, :cherokee]
  
  task :webserver_lib do
    tools = %w{zlib1g zlib1g-dev libpcre3 libpcre3-dev openssl ssl-cert libnss3-dev libssl-dev}
    install_pkg(tools)
  end
  
  desc "Install apache"
  task :apache => [:webserver_lib] do
    tools = %w{apache2 apache2-threaded-dev libapache2-mod-python libapache2-mod-python-doc libapache2-mod-wsgi libapache2-mod-php5}
    install_pkg(tools)
  end
  
  desc "Install nginx"
  task :nginx => [:webserver_lib] do
    tools = %w{}
    install_pkg(tools)
  end

  desc "Install cherokee"
  task :cherokee do
    tools = %w{cherokee libcherokee-mod-admin spawn-fcgi libcherokee-mod-libssl libcherokee-mod-mysql libcherokee-mod-rrd}
    install_pkg(tools)
  end
end
