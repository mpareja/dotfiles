#!/bin/bash

echo ======= Downloading installation scripts...
cd $(mktemp -d)
wget -q https://github.com/mpareja/dotfiles/archive/refs/heads/master.zip
unzip master.zip
cd dotfiles-master/ubuntu
./install.sh
