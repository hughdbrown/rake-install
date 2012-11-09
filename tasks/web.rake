namespace :web do
  #desc "Install xvfb"
  task :xvfb do
    install_pkg(["xvfb"])
  end
end
