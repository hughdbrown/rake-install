desc "Install desktop machine"
task :Desktop => ["universe", "media:media", "ubuntu:cinnamon"]

