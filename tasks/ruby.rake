namespace :ruby do
  #desc "Install ruby"
  task :install => ["system:curl"] do
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
    rubies = %w{ruby-1.9.2-p320 ruby-1.9.3-p392 ruby-2.0.0-p0}
    rubies.each{|ruby| sh("rvm install --verify-downloads 1 #{ruby}")}
  end
end

task :ruby => ["ruby:install"]
