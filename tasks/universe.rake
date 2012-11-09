namespace :universe do
  task :universe => ["security", "extra", "system"] do
    notice("Installed the universe")
  end
end

#desc "Install the universe"
task :universe => ["universe:universe"]
