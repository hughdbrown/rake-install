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
    FileUtils.mkdir(IRSSI_HOME) unless File.exists?(IRSSI_HOME)
    FileUtils.cd(IRSSI_HOME) do
      sh("wget --output-file=spring.theme http://www.irssi.org/themefiles/spring.theme")
    end
  end
  
  task :handbrake do
    install_ppa("ppa:stebbins/handbrake-snapshots")
    pkgs = %w{ handbrake-gtk handbrake-cli }
    install_pkg(pkgs)
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
    hosts_file = "/etc/hosts"
    if File.size(hosts_file) < 1024
      sh("wget -O- http://winhelp2002.mvps.org/hosts.txt | sudo tee -a #{hosts_file}")
    end
  end

  task :pidgin do
    pkgs = %w{ pidgin }
    install_pkg(pkgs)
  end

  task :adobe_reader do
    deb = "AdbeRdr9.5.1-1_i386linux_enu.deb"
    url = "ftp://ftp.adobe.com/pub/adobe/reader/unix/9.x/9.5.1/enu/#{deb}"
    install_deb(url, deb) unless File.exists?("/usr/bin/acroread")
  end
end

#desc "Install all media"
task :media => ["media:irssi", "media:handbrake", "media:abcde", "media:brasero", "media:hosts", "media:pidgin", "media:adobe_reader"]

