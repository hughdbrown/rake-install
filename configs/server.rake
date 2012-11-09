desc "Install server machine"
task :Server => ["universe", "ssh:open_ssh_server", "security", "mongo", "redis"]

