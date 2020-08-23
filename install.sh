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

config_i3() {
	if [ -e ~/.config/i3 ]; then
		echo Replacing i3 window manager configuration
		cd i3
		replace config ~/.config/i3/config
		cd ..
	fi
}

add_bashrc_source() {
	fileToPointTo=$1
	fileToEdit=$2
	reference=". $DOTFILES/$fileToPointTo"

	if ! grep -q "$reference" "$fileToEdit" ; then
		echo "Appending '$reference' to '$fileToEdit'"
		echo "$reference" >> "$fileToEdit"
	fi

}

echo Creating default ~/.bashrc
if [ -e /c ]; then
	# windows
	add_bashrc_source bashrc_win ~/.bashrc
elif [ "$(uname)" = "Darwin" ]; then
	# mac
	add_bashrc_source bashrc ~/.bashrc
	add_bashrc_source bashrc ~/.bash_profile

	config_tmux

	read -p 'Hit enter to launch solarized terminal, then click Shell > Use Settings as Default'
	open osx-terminal/solarized-dark.terminal
else
	add_bashrc_source bashrc ~/.bashrc
	$DOTFILES/gnome/solarized.sh dark

	config_tmux
	config_i3

	echo Adding apt-install to /bin
	APT_INSTALL="/bin/apt-install"
	[ -e $APT_INSTALL ] || sudo ln -s $DOTFILES/bin/apt-install $APT_INSTALL
fi

replace inputrc "$HOME/.inputrc"

./configure_git_defaults.sh
