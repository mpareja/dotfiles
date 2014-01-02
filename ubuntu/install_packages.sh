#!/bin/bash

echo ======= Adding external repositories...
add-apt-repository "deb http://linux.dropbox.com/ubuntu $(lsb_release -sc) main" # DROPBOX
add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner" # SKYPE
add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" # VIRTUALBOX
add-apt-repository ppa:gwendal-lebihan-dev/hexchat-stable # HEXCHAT
add-apt-repository ppa:ricotz/docky # PLANK

# add dropbox GPG key
apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E

echo ======= Installing packages...
apt-get update
xargs apt-get install -y < packages

echo ======= Installing n the node version manager...
cd $(mktemp -d)
git clone https://github.com/visionmedia/n .
make install

echo ======= Installing latest stable node...
n stable

