namespace :system do

  #desc "Install libnotify"
  task :libnotify do
    tools = %w{libnotify-bin}
    install_pkg(tools)
  end

  #desc "Install compiz"
  #task :compiz do
  #  tools = %w{compizconfig-settings-manager}
  #  install_pkg(tools)
  #end

  task :curl do
    tools = %w{libcurl3 libcurl3-gnutls libcurl4-openssl-dev curl}
    install_pkg(tools)
  end

  task :file_system_lib do
    # libcurl4-nss-dev 
    tools = %w{libfuse2 libfuse-dev libattr1-dev libxml2 libxml2-dev}
    install_pkg(tools)
  end

  #desc "Install file systems"
  task :file_systems => [:file_system_lib] do
    tools = %w{
        fuse-utils smbclient sshfs nfs-common encfs gvfs ecryptfs-utils
    }
    install_pkg(tools)
    install_pkg([cifs-utils])
    install_pkg([cifs-utils:i386])
  end
end

task :system => ["system:libnotify", "system:file_systems", "system:curl"]
