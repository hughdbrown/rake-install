namespace :chrome do
  desc "Install google chrome"
  task :install do
    sh("wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -")
    sh("sudo apt-get update")
    FileUtils.cd(TMP_DIR) do
      sh("wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb")
      # sh("sudo apt-get -y install google-chrome-stable")
      sh("sudo dpkg -i google-chrome* &&  sudo apt-get -f install")
    end
  end

end

task :chrome => ["chrome:install"]

