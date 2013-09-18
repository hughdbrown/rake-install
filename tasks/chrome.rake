namespace :chrome do
  desc "Install google chrome"
  task :install do
    sh("wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -")
    sh("sudo apt-get update")
    sh("sudo apt-get -y install google-chrome-stable")
  end

end

task :chrome => ["chrome:install"]

