namespace :vagrant do
    LUCID = "http://files.vagrantup.com/lucid32.box"

    desc "Install vagrant"
    task :vagrant do
        # pkgs = %w{ vagrant }
        # install_pkg(pkgs)
        deb = "vagrant_1.3.5_x86_64.deb"
        url = "http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/#{deb}"
        install_deb(url, deb)
        sh("vagrant box add base #{LUCID}")
    end
end
