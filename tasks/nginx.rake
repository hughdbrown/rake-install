namespace :nginx do
  NGINX_VER = "nginx-1.3.13"

  #desc "Make nginx prerequisites"
  task :prereq do
    tools = %w{zlib1g zlib1g-dev libpcre3 libpcre3-dev openssl}
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

  #desc "Make pagespeed"
  task :pagespeed do
    # From:
    #  https://developers.google.com/speed/docs/mod_pagespeed/build_from_source

    depends = %w{apache2 g++ python subversion gperf make devscripts fakeroot}
    install_pkg(depends)

    FileUtils.cd(TMP_DIR) do
      sh("svn co http://src.chromium.org/svn/trunk/tools/depot_tools")

      FileUtils.mkdir("mod_pagespeed") unless File.exists?("mod_pagespeed")
      FileUtils.cd("mod_pagespeed") do
        gclient = "../depot_tools/gclient"
        sh("#{gclient} config http://modpagespeed.googlecode.com/svn/branches/latest-beta/src")
        sh("#{gclient} sync --force --jobs=1")
      end
    end
    notice("Built pagespeed")
  end

  #desc "Test pagespeed"
  task :pagespeed_test => [:pagespeed] do
    FileUtils.cd(File.join(TMP_DIR, "mod_pagespeed", "src")) do
      sh("make BUILDTYPE=Release mod_pagespeed_test pagespeed_automatic_test")
      sh("./out/Release/mod_pagespeed_test")
      sh("./out/Release/pagespeed_automatic_test")
    end
    notice("Tested pagespeed")
  end

  #desc "Compile pagespeed"
  task :pagespeed_compile => [:pagespeed] do
    FileUtils.cd(File.join(TMP_DIR, "mod_pagespeed", "src")) do
      sh("make BUILDTYPE=Release")
      FileUtils.cd("#{TMP_DIR}/mod_pagespeed/src/net/instaweb/automatic") do
        sh("make all")
      end
    end
    notice("Compiled pagespeed")
  end

  #desc "Install pagespeed"
  task :pagespeed_install => [:pagespeed_compile] do
    FileUtils.cd(File.join(TMP_DIR, "mod_pagespeed", "src")) do
      sh("./ubuntu.sh staging")
      sh("sudo ./ubuntu.sh install")
      #sh("sudo ./ubuntu.sh stop start")
    end
  end

  #desc "Make mod_pagespeed"
  task :mod_pagespeed => [:pagespeed, :pagespeed_test, :pagespeed_compile, :pagespeed_install, "git:bin"] do
    FileUtils.cd(TMP_DIR) do
      sh("git clone git://github.com/pagespeed/ngx_pagespeed.git")
      notice("Built mod_pagespeed")
    end
  end

  #desc "install nginx source"
  task :nginx_src do
    FileUtils.cd(TMP_DIR) do
      sh("wget http://nginx.org/download/#{NGINX_VER}.tar.gz && tar xvfz #{NGINX_VER}.tar.gz && cd #{NGINX_VER}")

      # Fetch and apply the Nginx SPDY patch
      sh("wget http://nginx.org/patches/spdy/patch.spdy.txt")
      sh("patch -p0 < patch.spdy.txt")

      notice("Installed nginx source")
    end
  end

  #desc "Install nginx binary"
  task :nginx => [:prereq, :mod_wsgi, :mod_pagespeed, :nginx_src] do
    FileUtils.cd(TMP_DIR) do
      options = %w{
        --prefix=/usr/local/#{NGINX_VER}
        --conf-path=/etc/nginx/#{NGINX_VER}/nginx.conf
        --with-cc-opt="-w -Werror=unused-but-set-variable"
        --add-module=../mod_wsgi
        --add-module=../mod_pagespeed
        --without-mail_pop3_module
        --without-mail_imap_module
        --without-mail_smtp_module
        --without-http_rewrite_module
        --with-http_stub_status_module
        --with-http_ssl_module
        --with-http_mp4_module
        --with-pcre
        --with-debug
        --with-http_gzip_static_module
        --with-http_realip_module
      }
      begin
        configure_make(options)
      ensure
        # ...
      end
    end
  end
end

task :nginx => ["nginx:nginx"]
