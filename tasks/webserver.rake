namespace :webserver do
  task :webserver_lib do
    tools = %w{zlib1g zlib1g-dev libpcre3 libpcre3-dev openssl ssl-cert libnss3-dev libssl-dev}
    install_pkg(tools)
  end

  #desc "Install apache"
  task :apache => [:webserver_lib] do
    tools = %w{apache2 apache2-threaded-dev libapache2-mod-python libapache2-mod-python-doc libapache2-mod-wsgi libapache2-mod-php5}
    install_pkg(tools)
  end

  #desc "Install nginx"
  task :nginx => [:webserver_lib] do
    tools = %w{}
    install_pkg(tools)
  end

  #desc "Install cherokee"
  task :cherokee do
    tools = %w{cherokee libcherokee-mod-admin spawn-fcgi libcherokee-mod-libssl libcherokee-mod-mysql libcherokee-mod-rrd}
    install_pkg(tools)
  end

  #task :pancake do
  #  url = "http://github.com/pp3345/Pancake/tarball/1.1"
  #  version = "pp3345-Pancake-6975db6"
  #  install_tar(url, version)
  #end
end

#desc "Install webservers"
task :webserver => [
    "webserver:apache", 
    "webserver:nginx", 
    #"webserver:cherokee"
]

