#!/bin/bash

# add repositories
add-apt-repository "deb http://linux.dropbox.com/ubuntu $(lsb_release -sc) main" # DROPBOX
add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" # SKYPE
add-apt-repository ppa:gwendal-lebihan-dev/hexchat-stable # HEXCHAT

# add dropbox GPG key
apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E

# install a whack of packages
apt-get update
wget -q -O - https://raw.github.com/mpareja/dotfiles/master/ubuntu/packages | xargs apt-get install -y

# install n (node version manager)
tmp=$(mktemp -d)
git clone https://github.com/visionmedia/n $tmp
cd $tmp
make install

# install latest stable node
n stable

