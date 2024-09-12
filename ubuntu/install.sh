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

read -n 1 -p 'Do you want to configure GitHub (y/N)? ' INST_GITHUB
read -n 1 -p 'Do you want to install Docker (y/N)? ' INST_DOCKER
read -n 1 -p 'Do you want to install N node version manager (y/N)? ' INST_N
read -n 1 -p 'Do you want to recreate Vim folder (y/N)? ' INST_VIM
read -n 1 -p 'Do you want to install Dropbox (y/N)? ' INST_DROPBOX

echo

header Installing and configuring machine...

# packages require by installer
sudo apt install -y curl wget git

[ "$INST_CHROME" == 'y' ] && echo && install_chrome
[ "$INST_GITHUB" == 'y' ] && echo && configure_github
[ "$INST_DOCKER" == 'y' ] && echo && install_docker # required by dotfiles for kmonad install

install_dotfiles

# ubuntu .bashrc will not run when non-interactive, so we need
# to ensure these vars are configured so:
# 1. n is configured correctly
# 2. vim install can leverage `npm` which it needs
export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

[ "$INST_N" == 'y' ] && echo && install_n
[ "$INST_VIM" == 'y' ] && echo && configure_vim # must be after installing node

[ "$INST_DROPBOX" == 'y' ] && echo && install_dropbox

# need a final command since above conditional can have valid non-zero exit code
# which would inadvertantly trigger the "setup failed" message
echo
