namespace :ssh do

  desc "Install openssh-server"
  task :open_ssh_server do
    install_pkg(["openssh-server"])
  end
end
