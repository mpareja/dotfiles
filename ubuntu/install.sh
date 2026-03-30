#!/bin/bash

set -euo pipefail

finish() {
	local code=$?

	echo
	if [ $code -eq 0 ]; then
		echo 'Setup completed successfully.'
		echo
		echo "If this is the initial run, you'll want to restart so .profile and docker group can take affect."
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

read -n 1 -p 'Do you want to install Docker (y/N)? ' INST_DOCKER; echo
read -n 1 -p 'Do you want to install N node version manager (y/N)? ' INST_N; echo
read -n 1 -p 'Do you want to install keyd (y/N)? ' INST_KEYD; echo
read -n 1 -p 'Vim cannot be installed until Ansible setup has completed. Do you want to recreate Vim folder (y/N)? ' INST_VIM; echo

echo

header Installing and configuring machine...

# packages require by installer
sudo apt install -y ansible-core curl git make openssh-server wget

configure_github

[ "$INST_DOCKER" == 'y' ] && echo && install_docker # required by dotfiles for kmonad install
[ "$INST_KEYD" == 'y' ] && echo && echo "Installing keyd..." && ../keyd/install.sh

install_dotfiles

# ubuntu .bashrc will not run when non-interactive, so we need
# to ensure these vars are configured so:
# 1. n is configured correctly
# 2. vim install can leverage `npm` which it needs
export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

[ "$INST_N" == 'y' ] && echo && install_n
[ "$INST_VIM" == 'y' ] && echo && configure_vim # must be after installing node

# need a final command since above conditional can have valid non-zero exit code
# which would inadvertantly trigger the "setup failed" message
echo
