namespace :rubygems do
  gems = %w{
    awesome_print
    aws-s3
    builder
    bundler
    grit
    guard
    json
    kramdown
    markdown
    net-scp
    net-ssh
    pry
    rack
    rake
    redis
    resque
    rugged
    rvm
    sass
    showterm
    sinatra
    slideshow
    thin
    thor
    tmuxinator
    unicorn
  }.sort

  #desc "Install ruby-dev prerequisite"
  # If you do not install this, you will get 'mkmf not found' errors
  task :ruby_dev do
    pkg = %w{ ruby1.9.1-dev }
    install_pkg(pkg)
  end

  #desc "Install ruby gems"
  task :install => [:ruby_dev] do
    install_gems(gems)
  end

  #desc "Upgrade ruby gems"
  task :upgrade => [:ruby_dev] do
    upgrade_gems(gems)
  end
end

task :rubygems => ["rubygems:install"]
