#!/bin/bash

EMAIL=pareja.mario@gmail.com

sudo ./install_packages.sh

# install google chrome
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
software-cente /tmp/google-chrome-stable_current_amd64.deb

# configure GitHub keys
mkdir -p ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -C "$EMAIL" -f ./id_rsa
echo Adding key to GitHub account
curl -u $USER https://api.github.com/user/keys -H 'Content-Type: application/json' -d "{\"title\": \"$(hostname)\",\"key\": \"$(cat ~/.ssh/id_rsa.pub)\"}"

# configure dotfiles
mkdir -p ~/projects
cd ~/projects
git clone git@github.com:mpareja/dotfiles.git
cd dotfiles
./install.sh

# configure vim
echo About to recreate ~/.vim directory...
rm -rI ~/.vim
git clone git@github.com:mpareja/vim-settings.git ~/.vim
cd ~/.vim
./install.sh



