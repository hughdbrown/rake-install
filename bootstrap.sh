#!/bin/sh -e

mkdir ~/bin ~/tmp

sudo apt-get install -y curl
sudo apt-get install -y git zsh 
sudo chsh
sudo apt-get install -y vim vim-gnome 

sudo apt-get install -y python-pip
sudo pip install virtualenv virtualenvwrapper

sudo apt-get install ruby
gem install rake rvm
sudo apt-get install libyaml-dev
rvm install ruby-1.9.3-p362 --verify-downloads 1

