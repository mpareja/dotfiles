#!/bin/bash
export DOTFILES=$(pwd)

replace () {
	if [ -z "$2" ]; then
		target="$HOME/.$1"
	else
		target="$2"
	fi
	[ -e $target ] && rm $target
	ln "$1" $target
}

config_tmux() {
	echo Replacing tmux configuration files
	cd tmux
	replace tmux.conf
	replace tmuxcolors.conf
	cd ..
}

echo Creating default ~/.bashrc
if [ -e /c ]; then
	# windows
	echo ". $DOTFILES/bashrc_win" > ~/.bashrc
elif [ "$(uname)" = "Darwin" ]; then
	# mac
	echo ". $DOTFILES/bashrc" > ~/.bashrc
	echo ". $DOTFILES/bashrc" > ~/.bash_profile

	config_tmux

	read -p 'Hit enter to launch solarized terminal, then click Shell > Use Settings as Default'
	open osx-terminal/solarized-dark.terminal
else
	echo ". $DOTFILES/bashrc" > ~/.bashrc
	$DOTFILES/gnome/solarized.sh dark

	config_tmux

	echo Adding apt-install to /bin
	APT_INSTALL="/bin/apt-install"
	[ -e $APT_INSTALL ] || sudo ln -s $DOTFILES/bin/apt-install $APT_INSTALL
fi

replace inputrc "$HOME/.inputrc"

./configure_git_defaults.sh
