namespace :zsh do
  task :install do
    pkgs = %w{zsh}
    install_pkg(pkgs)
    sh("sudo chsh --shell /bin/zsh")
  end
end

task :zsh => ["zsh:install"]
