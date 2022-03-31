#!/bin/bash

set -euo pipefail

finish() {
	local code=$?

	echo
	if [ $code -eq 0 ]; then
		echo Setup completed successfully.
	else
		echo ERROR: setup failed.
		exit $code
	fi
}

trap finish EXIT

. ./config
. ./functions

echo "GIT_EMAIL:    $GIT_EMAIL"
echo "GIT_USERNAME: $GIT_USERNAME"
echo

read -n 1 -p 'Do you want to install Chrome (y/N)? ' INST_CHROME
read -n 1 -p 'Do you want to install Dropbox (y/N)? ' INST_DROPBOX
read -n 1 -p 'Do you want to install Docker (y/N)? ' INST_DOCKER
read -n 1 -p 'Do you want to install N node version manager (y/N)? ' INST_N
read -n 1 -p 'Do you want to install VirtualBox (y/N)? ' INST_VBOX
read -n 1 -p 'Do you want to configure GitHub (y/N)? ' INST_GITHUB
read -n 1 -p 'Do you want to install dbeaver SQL client (y/N)? ' INST_DBEAVER

echo

header Installing and configuring machine...

sudo ./install_packages.sh

[ "$INST_CHROME" == 'y' ] && echo && install_chrome
[ "$INST_GITHUB" == 'y' ] && echo && configure_github

install_dotfiles
. ~/.bashrc # Apply bash profile updates

[ "$INST_DOCKER" == 'y' ] && echo && install_docker
[ "$INST_N" == 'y' ] && echo && install_n # I suspect needs to be after `dotfiles` due to bash profile updates
configure_vim # must be after installing node

[ "$INST_DROPBOX" == 'y' ] && echo && install_dropbox
[ "$INST_VBOX" == 'y' ] && echo && install_virtualbox
[ "$INST_DBEAVER" = 'y' ] && echo && install_dbeaver
