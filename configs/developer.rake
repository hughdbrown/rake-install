desc "Install developer machine"
task :Developer => ["universe", "git", "vim", "rubygems:install", "virtualbox", "virtualenv", "node", "python"]

