namespace :zsh do
  task :install do
    pkgs = %w{zsh}
    install_pkg(pkgs)
    FileUtils.cd(HOME) do
      sh("curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh")
    end
    sh("sudo chsh --shell=/bin/zsh")
  end
end

task :zsh => ["zsh:install"]
