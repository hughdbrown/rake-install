namespace :tmux do
  TMUX_VERSION_STR = "1.9"

  desc "Install libevent"
  task :libevent do
    pkgs = %w{ libevent-dev }
    install_pkg(pkgs)
  end

  desc "Install tmux (terminal multiplexer)"
  task :bin => [:libevent] do
    version = "tmux-#{TMUX_VERSION_STR}"
    url = "http://downloads.sourceforge.net/tmux/#{version}.tar.gz"
    #test_fn = Proc.new {
    #  expect = /MongoDB shell version: #{TMUX_VERSION_STR}/
    #  (not command_exists("tmux")) || (`tmux --version`.strip.scan(expect).length == 0)
    #}

    #b = Proc.new {
    #  FileUtils.cd(File.join(TMP_DIR, version, "bin")) do
    #    notice("Moving files to /usr/bin/")
    #    sh("sudo mv * /usr/bin/.")
    #  end
    #}

    #install_tar(url, version, {:block => b, :test => test_fn})
    install_tar(url, version)
  end
end

task :tmux => ["tmux:bin"]
