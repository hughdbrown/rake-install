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

  desc "Install handbrake (a client for creating digital video)"
  task :handbrake do
    install_ppa("ppa:stebbins/handbrake-snapshots")
    pkgs = %w{ handbrake-gtk handbrake-cli }
    install_pkg(pkgs)
  end

  desc "Install irssi (a n IRC client)"
  task :irssi => [SPRING_THEME] do
    # irssi IRC terminal-based client
    # http://www.techdrivein.com/2010/07/irssi-really-good-terminal-based-irc.html
    pkgs = %w{ irssi }
    install_pkg(pkgs)
  end

  desc "Install abcde (for ripping CDs)"
  task :abcde do
    pkgs = %w{ abcde lame id3v2 }
    install_pkg(pkgs)
  end

  desc "Install youtube_dl (fordownloading from youtube)"
  task :youtube_dl do
    app = "/usr/local/bin/youtube-dl"
    version = "2013.09.17"
    sh("sudo wget http://youtube-dl.org/downloads/#{version}/youtube-dl -O #{app} && sudo chmod a+x #{app}")
  end

  desc "Install brasero (for ripping DVDs)"
  task :brasero do
    pkgs = %w{ brasero libdvdcss2 }
    install_pkg(pkgs)
  end

  desc "Install hosts file"
  task :hosts do
    hosts_file = "/etc/hosts"
    if File.size(hosts_file) < 1024
      sh("wget -O- http://winhelp2002.mvps.org/hosts.txt | sudo tee -a #{hosts_file}")
    end
  end

  desc "Install pidgin (an IM client)"
  task :pidgin do
    pkgs = %w{ pidgin }
    install_pkg(pkgs)
  end

  desc "Fix medibuntu"
  task :medibuntu do
    sh("sudo sed -i '/.*medibuntu\.org.*/d' /etc/apt/sources.list")
    sh("echo 'deb http://mirrors.ucr.ac.cr/medibuntu/ raring free non-free' | sudo tee -a /etc/apt/sources.list")
  end

  desc "Install Adobe reader"
  task :adobe_reader do
    pkgs = %w{ cups-pdf libgtk2.0-0 }
    install_pkg(pkgs)

    bin = "AdbeRdr9.5.5-1_i386linux_enu.bin"
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
  desc "Install Adobe plugins"
  task :adobe do
    #pkgs = %w{adobe-flashplugin flashplugin-installer}
    pkgs = %w{adobe-flashplugin}
    install_pkg(pkgs)
    pkgs = %w{flashplugin-installer}
    install_pkg(pkgs)
  end

  desc "Install screenkey (for recording screen captures)"
  task :kazam do
    pkgs = %w{kazam}
    install_pkg(pkgs)
  end

  desc "Install screenkey (for screen demos)"
  task :screenkey do
    pkgs = %w{screenkey}
    install_pkg(pkgs)
  end

  desc "Install skype"
  task :skype do
    dependencies = %w{
        libasound2
        libqt4-dbus libqt4-network libqt4-xml libqtcore4 libqtgui4 libqtwebkit4
        libstdc++6
        libx11-6 libxext6 libxss1 libxv1
        libssl1.0.0
    }
    install_pkg(dependencies)

    # 2013-11-15: Need to install these 32-bit drivers because skype is 32-bit
    dependencies = %w{libasound2-plugins:i386}
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
