#!/bin/bash

echo ======= Downloading installation scripts...
cd $(mktemp -d)
wget -q https://raw.github.com/mpareja/dotfiles/master/ubuntu/config
wget -q https://raw.github.com/mpareja/dotfiles/master/ubuntu/install.sh
wget -q https://raw.github.com/mpareja/dotfiles/master/ubuntu/install_packages.sh
wget -q https://raw.github.com/mpareja/dotfiles/master/ubuntu/packages

chmod +x *.sh

./install.sh
