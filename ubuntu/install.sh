#!/bin/bash

. ./functions
. ./config

header Installing and configuring machine...

sudo ./install_packages.sh

chrome
github
dotfiles
vim
plank
defaultapps
docker

read -n 1 -p 'Do you want to install VirtualBox (y/N)? ' CONFIRM
[ $CONFIRM = 'y' ] && echo && sudo virtualbox

read -n 1 -p 'Do you want to install dbeaver SQL client (y/N)? ' CONFIRM
[ $CONFIRM = 'y' ] && echo && sudo dbeaver
