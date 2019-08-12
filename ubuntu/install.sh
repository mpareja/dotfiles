#!/bin/bash

. ./functions
. ./config

read -n 1 -p 'Do you want to install Dropbox (y/N)? ' INST_DROPBOX
read -n 1 -p 'Do you want to install VirtualBox (y/N)? ' INST_VBOX
read -n 1 -p 'Do you want to install dbeaver SQL client (y/N)? ' INST_DBEAVER

echo

header Installing and configuring machine...

sudo ./install_packages.sh

chrome
github
dotfiles
defaultapps
docker
install_node # I suspect needs to be after `dotfiles` due to bash profile updates
vim # must be after installing node

[ "$INST_DROPBOX" == 'y' ] && echo && dropbox
[ "$INST_VBOX" == 'y' ] && echo && virtualbox
[ "$INST_DBEAVER" = 'y' ] && echo && dbeaver
