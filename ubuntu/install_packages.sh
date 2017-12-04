#!/bin/bash

echo ======= Adding external repositories...
add-apt-repository "deb http://linux.dropbox.com/ubuntu $(lsb_release -sc) main" # DROPBOX
add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" # SKYPE
add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" # VIRTUALBOX
add-apt-repository "deb http://debian.sur5r.net/i3/ $(lsb_release -sc) universe" # i3wm
add-apt-repository -y ppa:gwendal-lebihan-dev/hexchat-stable # HEXCHAT
add-apt-repository -y ppa:ricotz/docky # PLANK
add-apt-repository -y ppa:synapse-core/testing # SYNAPSE (not found in Ubuntu 14.04)
add-apt-repository -y ppa:serge-rider/dbeaver-ce # dbeaver (optional dependency)

# add dropbox GPG key
apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E

# add VirtualBox GPG key
wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | apt-key add -

echo ======= Installing packages...
apt-get update
xargs apt-get install -y < packages

echo ======= Installing n the node version manager...
cd $(mktemp -d)
git clone https://github.com/visionmedia/n .
make install

echo ======= Installing latest stable node and npm...
n stable
npm install -g npm

