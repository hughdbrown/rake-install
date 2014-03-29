namespace :nginx do
  NGINX_VER = "nginx-1.5.12"
  PSOL_VER = "1.7.30.3"
  PSOL_TAR = "#{PSOL_VER}.tar.gz"
  PAGESPEED_VER = "#{PSOL_VER}-beta"
  PAGESPEED_ZIP = "v#{PAGESPEED_VER}.zip"
  PAGESPEED_DIR = "ngx_pagespeed-#{PAGESPEED_VER}"
  NGINX_INIT = "data/nginx"

  #desc "Make nginx prerequisites"
  task :prereq do
    tools = %w{zlib1g zlib1g-dev libpcre3 libpcre3-dev openssl libxml2-dev libxslt-dev}
    install_pkg(tools)
    notice("Installed nginx prerequisites")
  end

  #desc "Make mod_wsgi"
  task :mod_wsgi => ["mercurial:bin"] do
    FileUtils.cd(TMP_DIR) do
      sh("hg clone http://bitbucket.org/lifeeth/mod_wsgi/")
      sh("cd mod_wsgi")
      sh("sudo python setup.py --prefix=/usr/local/#{NGINX_VER} install")
      notice("Built mod_wsgi")
    end
  end

  # https://github.com/pagespeed/ngx_pagespeed
  task :nginx_pagespeed do
    depends = %w{ build-essential zlib1g-dev libpcre3 libpcre3-dev }
    install_pkg(depends)

    FileUtils.cd(TMP_DIR) do
      wget_cmd = "wget -O #{PAGESPEED_ZIP} https://github.com/pagespeed/ngx_pagespeed/archive/#{PAGESPEED_ZIP}"
      expand_cmd = "unzip #{PAGESPEED_ZIP}"
      sh(wget_cmd)
      sh(expand_cmd)
      notice("Installed nginx pagespeed")
      FileUtils.cd(PAGESPEED_DIR) do
        wget_cmd = "wget -O #{PSOL_TAR} https://dl.google.com/dl/page-speed/psol/#{PSOL_TAR}"
        expand_cmd = "tar -xzvf #{PSOL_TAR}"
        sh(wget_cmd)
        sh(expand_cmd)
        notice("Installed nginx psol")
      end
    end
  end

  #desc "install nginx source"
  task :nginx_src do
    FileUtils.cd(TMP_DIR) do
      sh("wget -O #{NGINX_VER}.tar.gz http://nginx.org/download/#{NGINX_VER}.tar.gz && tar xvfz #{NGINX_VER}.tar.gz && cd #{NGINX_VER}")
      notice("Installed nginx source")
    end
  end

  desc "Install nginx binary (with mod_wsgi and pagespeed)"
  #:mod_wsgi
  # --add-module=../mod_wsgi
  task :nginx => [:prereq, :nginx_src, :nginx_pagespeed] do
    FileUtils.cd(TMP_DIR) do
      FileUtils.cd(NGINX_VER) do
        options = %W{
          --prefix=/usr
          --user=www-data
          --group=www-data
          --conf-path=/etc/nginx/nginx.conf
          --error-log-path=/var/log/nginx/error.log
          --with-cc-opt="-w -Werror=unused-but-set-variable"
          --http-client-body-temp-path=/var/lib/nginx/body
          --http-fastcgi-temp-path=/var/lib/nginx/fastcgi
          --http-log-path=/var/log/nginx/access.log
          --http-proxy-temp-path=/var/lib/nginx/proxy
          --http-scgi-temp-path=/var/lib/nginx/scgi
          --http-uwsgi-temp-path=/var/lib/nginx/uwsgi
          --lock-path=/var/lock/nginx.lock
          --pid-path=/var/run/nginx.pid
          --with-debug
          --with-http_addition_module
          --with-http_gzip_static_module
          --with-http_realip_module
          --with-http_spdy_module
          --with-http_stub_status_module
          --with-http_ssl_module
          --with-http_sub_module
          --with-http_xslt_module
          --with-ipv6
          --with-pcre
          --with-pcre-jit
          --with-sha1=/usr/include/openssl
          --with-md5=/usr/include/openssl
          --without-mail_pop3_module
          --without-mail_imap_module
          --without-mail_smtp_module
          --without-http_rewrite_module
          --add-module=#{TMP_DIR}/ngx_pagespeed-#{PAGESPEED_VER}
        }
        begin
          configure_make(options)
        ensure
          # ...
        end
        notice("Installed nginx binary")
      end
    end
    Rake::Task["nginx:service"].invoke
    Rake::Task["nginx:adduser"].invoke
  end

  desc "Install nginx service"
  task :service do
    add_service("nginx", NGINX_INIT)
  end

  desc "Add a user for nginx to run as"
  task :adduser do
    sh("sudo adduser --system --no-create-home --disabled-login --disabled-password --group nginx")
  end
end

task :nginx => ["nginx:nginx"]
