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
    sinatra
    slideshow
    thin
    thor
    tmuxinator
    unicorn
    vagrant
  }.sort

  desc "Install ruby gems"
  task :install do
    install_gems(gems)
  end
  
  desc "Upgrade ruby gems"
  task :upgrade do
    upgrade_gems(gems)
  end
end

task :rubygems => ["rubygems:install"]
