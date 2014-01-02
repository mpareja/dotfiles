#!/bin/bash

. ./config

sudo ./install_packages.sh

echo ======= Installing Google Chrome...
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome-stable_current_amd64.deb
software-center /tmp/google-chrome-stable_current_amd64.deb

echo ======= Configure GitHub SSH key...
mkdir -p ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -C "$GIT_EMAIL" -f ./id_rsa
echo Adding key to GitHub account
curl -u $GIT_USERNAME https://api.github.com/user/keys -H 'Content-Type: application/json' -d "{\"title\": \"$(hostname)\",\"key\": \"$(cat id_rsa.pub)\"}"

echo ======= Configure dotfiles...
mkdir -p ~/projects
cd ~/projects
git clone git@github.com:$GIT_USERNAME/dotfiles.git
cd dotfiles
./install.sh

echo ======= About to recreate ~/.vim directory...
rm -rI ~/.vim
git clone git@github.com:$GIT_USERNAME/vim-settings.git ~/.vim
cd ~/.vim
./install.sh



