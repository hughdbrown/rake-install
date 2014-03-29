namespace :dropbox do
    DROPBOX_INIT = "data/dropbox"

    desc "Install dropbox as service"
    task :dropbox do
        # http://www.spritian.com/2012/05/13/install-dropbox-as-a-service-on-linux/
        # http://ubuntuservergui.com/ubuntu-server-guide/install-dropbox-ubuntu-server
        FileUtils.cd(HOME) do
            deb = "dropbox_1.6.0_amd64.deb"
            url = "https://www.dropbox.com/download?dl=packages/ubuntu/#{deb}"
            install_deb(url, deb)
        end
        Rake::Task["dropbox:service"].invoke
    end

    desc "Install dropbox service"
    task :service do
        add_service("dropbox", DROPBOX_INIT)
    end
end
