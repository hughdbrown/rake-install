namespace :schwab do
    ICA_CLIENT_DEB_URL = "https://help.ubuntu.com/community/CitrixICAClientHowTo?action=AttachFile&do=get&target=icaclient_12.1.0_amd64.deb"
    ICA_CLIENT_DEBNAME = "icaclient-12.1.0_i386.deb"

    task "Install dependencies"
    task :icadependency do
        pkgs = %w{ libmotif4:i386 libxaw7 nspluginwrapper libmotif4 flashplugin-installer curl ia32-libs lib32asound2 lib32z1 }
        install_pkg(pkgs)
    end

    desc "Install icaclient and dependencies"
    task :icaclient => [:icadependency] do
        FileUtils.cd(TMP_DIR) do
            sh("wget -O #{ICA_CLIENT_DEBNAME} \"#{ICA_CLIENT_DEB_URL}\"")
            sh("sudo dpkg --force-architecture -i #{ICA_CLIENT_DEBNAME}")
        end
    end
end

