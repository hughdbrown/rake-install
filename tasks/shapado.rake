namespace :shapado do
  WORKSPACE = "~/workspace"
   
  #desc "Install shapado"
  task :shapado => ["ruby:install", "git:bin"] do
    pkgs = %w{
      libqt4-dev
      qt4-qmake
      libxml2 libxml2-dev libxslt1-dev
      libreadline-dev
    }
    install_pkg(pkgs)
    FileUtils.cd(WORKSPACE) do
      sh("git clone git://gitorious.org/shapado/shapado.git")
      FileUtils.cd("shapado") do
        sh("rvm use && bundle install")
      end
    end
    notice("Installed shapado")

  end
end
