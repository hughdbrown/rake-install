# picasa
#./install-picasa.sh
#
# Medibuntu
#./install-medibuntu.sh

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
    app = "/usr/local/bin/youtube-dl"
    version = "2013.09.17"
    sh("sudo wget http://youtube-dl.org/downloads/#{version}/youtube-dl -O #{app} && sudo chmod a+x #{app}")
  end

  task :brasero do
    pkgs = %w{ brasero libdvdcss2 }
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

  task :skype do
    dependencies = %w{libasound2 libqt4-dbus libqt4-network libqt4-xml libqtcore4 libqtgui4 libqtwebkit4 libstdc++6 libx11-6 libxext6 libxss1 libxv1 libssl1.0.0}
    install_pkg(dependencies)

    deb = "skype-ubuntu-precise_4.2.0.11-1_i386.deb"
    install_deb("http://download.skype.com/linux/#{deb}", deb)
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
    "media:youtube_dl",
    "media:skype"
]
