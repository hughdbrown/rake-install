# handbrake
#./install-handbrake.sh
#
# picasa
#./install-picasa.sh
#
# Medibuntu
#./install-medibuntu.sh
#
#./install-skype.sh

namespace :media do
  IRSSI_HOME = File.join(HOME, ".irssi")
  SPRING_THEME = File.join(IRSSI_HOME, "spring.theme")

  file SPRING_THEME do
    FileUtils.cd(IRSSI_HOME) do
      sh("wget --output-file=spring.theme http://www.irssi.org/themefiles/spring.theme")
    end
  end

  task :irssi => [SPRING_THEME] do
    # irssi IRC terminal-based client
    # http://www.techdrivein.com/2010/07/irssi-really-good-terminal-based-irc.html
    pkgs = %w{ irssi }
    install_pkg(pkgs)
  end

  task :abcde do
    pkgs = %w{ abcde lame id3v2 }
    install_pkg(pkgs)    
  end

  task :brasero do
    pkgs = %w{ brasero }
    install_pkg(pkgs)  
  end

  task :hosts do
    sh("wget -O- http://winhelp2002.mvps.org/hosts.txt | sudo tee -a /etc/hosts")
  end

  task :pidgin do
    pkgs = %w{ pidgin }
    install_pkgs(pkgs)
  end

  task :adobe_reader do
    deb = "AdbeRdr9.5.1-1_i386linux_enu.deb"
    url = "wget ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.1/enu/#{deb}"
    install_deb(url, deb)
  end
end

#desc "Install all media"
task :media => ["media:irssi", "media:abcde", "media:brasero", "media:hosts", "media:pidgin", "media:adobe_reader"]

