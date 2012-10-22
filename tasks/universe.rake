namespace :universe do
  task :universe => ["system:file_systems", "ssh:open_ssh_server", "security", "extra", "dev", "git", "vim", "rubygems", "webserver"] do
    notify("Installed the universe")
  end
end

desc "Install the universe"
task :universe => ["universe:universe"]
