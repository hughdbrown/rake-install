namespace :ubuntu do
  appmenu_packages = %w{appmenu-gtk3 appmenu-gtk appmenu-qt}
  amazon_packages = %w{unity-lens-shopping}
  mate_packages = %w{mate-archive-keyring mate-core mate-desktop-environment}
  
  desc "Install cinnamon library"
  task :cinnamon do
    # ppa = "ppa:merlwiz79/cinnamon-ppa"
    ppa = "gwendal-lebihan-dev/cinnamon-stable"
    install_ppa(ppa)
    cinnamon_packages = %w{cinnamon cinnamon-session cinnamon-settings libmuffin0 gir1.2-muffin-3.0}
    install_pkg(cinnamon_packages)
    
    Rake::Task["ubuntu:remove_appmenu"].invoke()
  end


  desc "Install mate library"
  task :mate do
    install_ppa("deb http://packages.mate-desktop.org/repo/ubuntu quantal main")
    install_pkg(mate_packages)
  end
  
  desc "Remove appmenu packages"
  task :remove_appmenu do
    remove_pkg(appmenu_packages)
  end

  desc "Remove amazon packages"
  task :remove_amazon do
    remove_pkg(amazon_packages)
  end

  desc "Install appmenu packages"
  task :install_appmenu do
    install_pkg(appmenu_packages)
  end
end

task :ubuntu => ["ubuntu:cinnamon"]
