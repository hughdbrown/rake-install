namespace :schwab do
    # ICA_CLIENT_DEB_URL = "https://help.ubuntu.com/community/CitrixICAClientHowTo?action=AttachFile&do=get&target=icaclient_12.1.0_amd64.deb"
    # ICA_CLIENT_DEBNAME = "icaclient-12.1.0_i386.deb"
    ICA_CLIENT_DEB_URL = "http://download.citrix.com.edgesuite.net/akdlm/8618/icaclient_13.0.0.256735_amd64.deb?__gda__=1389824783_7175e8e560aabe1d0fb687f9b5b77e49&__dlmgda__=1389907837_1edad505574e0c251823f5a85a4e6aca&fileExt=.deb"
    ICA_CLIENT_DEBNAME = "icaclient_13.0.0.256735_amd64"

    task "Install dependencies"
    task :icadependency do
        # icaclient_13.0.0.256735_amd64 may require: libxerces-c3.1 libwebkit-dev
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
