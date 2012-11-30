namespace :ruby do
  #desc "Install ruby"
  task :install do
    pkgs = %w{
      build-essential openssl libreadline6 libreadline6-dev
      curl git-core zlib1g zlib1g-dev libssl-dev
      libyaml-dev
      libsqlite3-dev sqlite3
      libxml2-dev libxslt-dev
      autoconf
      libc6-dev ncurses-dev automake
      libtool bison subversion pkg-config    
    }
    install_pkg(pkgs)
    sh("rvm install 1.9.3")
  end
end

task :ruby => ["ruby:install"]
