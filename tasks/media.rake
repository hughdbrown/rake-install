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
    #desc "Install media tools"
    task :media do
        # irssi IRC terminal-based client
        # http://www.techdrivein.com/2010/07/irssi-really-good-terminal-based-irc.html
        pkgs = %w{ irssi brasero abcde lame id3v2 }
        install_pkg(pkgs)
    end
end

#desc "Install all media"
task :media => ["media:media"]

