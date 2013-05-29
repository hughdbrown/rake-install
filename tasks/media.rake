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

  task :youtube_dl do
    sh("sudo wget http://youtube-dl.org/downloads/2013.02.25/youtube-dl -O /usr/local/bin/youtube-dl && sudo chmod a+x /usr/local/bin/youtube-dl")
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
    install_pkg(["libgtk2.0-0"])

    bin = "AdbeRdr9.5.5-1_i486linux_enu.bin"
    url = "http://ardownload.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/#{bin}"
    FileUtils.cd(TMP_DIR) do
      sh("wget #{url}")
      sh("chmod +x #{bin}")
      sh("sudo ./#{bin}")
    end
    #install_deb(url, deb) unless File.exists?("/usr/bin/acroread")
  end

  # Requires explicitly enabling libflashplayer and disabling libpepflashplayer.
  # http://helpx.adobe.com/flash-player/kb/flash-player-google-chrome.html
  # Only affects Chrome.
  # Type "about:plugins" in Chrome navigation bar.
  task :adobe do
    #pkgs = %w{adobe-flashplugin flashplugin-installer}
    pkgs = %w{adobe-flashplugin}
    install_pkg(pkgs)
    pkgs = %w{flashplugin-installer}
    install_pkg(pkgs)
  end

  task :kazam do
    pkgs = %w{kazam}
    install_pkg(pkgs)
  end

  task :screenkey do
    pkgs = %w{screenkey}
    install_pkg(pkgs)
  end
end

#desc "Install all media"
task :media => [
    "media:irssi",
    "media:handbrake",
    "media:abcde",
    "media:brasero",
    "media:hosts",
    "media:pidgin",
    "media:adobe_reader",
    "media:kazam",
    "media:adobe",
    "media:screenkey",
    "media:youtube_dl"
]
