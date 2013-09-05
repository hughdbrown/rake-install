namespace :dropbox do
    DROPBOX_INIT = "data/dropbox"
    task :dropbox do
        # http://www.spritian.com/2012/05/13/install-dropbox-as-a-service-on-linux/
        # http://ubuntuservergui.com/ubuntu-server-guide/install-dropbox-ubuntu-server
        FileUtils.cd(HOME) do
            # version = sh("uname -p")
            version = "x86_64"
            url = "https://www.dropbox.com/download?plat=#{version}"
            sh("wget -O - #{url} | tar xzf")
            sh("sudo cp -v #{DROPBOX_INIT} /etc/init.d/.")
            sh("sudo chmod +x /etc/init.d/dropbox && sudo update-rc.d dropbox defaults")
        end
    end
end


