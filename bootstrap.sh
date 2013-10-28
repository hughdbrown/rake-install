#!/bin/sh -e

mkdir -p ~/bin ~/tmp

# sudo apt-get install -y lib32stdc++6
sudo apt-get install -y python-dev
sudo apt-get install libreadline6-dev zlib1g-dev libssl-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison libffi-dev

sudo apt-get install -y curl
sudo apt-get install -y git zsh 
chsh -s /bin/zsh
sudo apt-get install -y vim vim-gnome 

sudo apt-get install -y python-pip
sudo pip install virtualenv virtualenvwrapper

sudo apt-get install -y libyaml-dev
sudo apt-get install -y ruby
sudo gem install rake
curl -L https://get.rvm.io | bash -s stable --ruby
rvm install ruby-1.9.3-p385 --verify-downloads 1

