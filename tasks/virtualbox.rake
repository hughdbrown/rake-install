namespace :virtualbox do
    #desc "Install virtualbox"
    task :virtualbox => ["dev:essential"] do
        pkgs = %w{ virtualbox-4.2 }
        install_pkg(pkgs)
        pkgs = %w{ virtualbox-guest-additions }
        install_pkg(pkgs)
    end
    
    # Alternative installation from iso
    # http://www.cyberciti.biz/faq/ubuntu-mount-iso-image/
    # wget http://download.virtualbox.org/virtualbox/4.2.6/VBoxGuestAdditions_4.2.6.iso
    # sudo mkdir /mnt/iso
    # sudo mount -o loop VBoxGuestAdditions_4.2.6.iso /mnt/iso
    # cd /mnt/iso
    # sudo sh ./VBoxLinuxAdditions.run
    # sudo umount /mnt/iso
end

#desc "Install virtualbox"
task :virtualbox => ["virtualbox:virtualbox"]
