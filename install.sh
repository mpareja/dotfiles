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
	echo Replacing i3 window manager configuration

	cd i3

	if [ -d /etc/regolith ]; then
		mkdir -p ~/.config/regolith/i3

		replace config ~/.config/regolith/i3/config
	else
		mkdir -p ~/.config/i3

		replace config ~/.config/i3/config
	fi

	cd ..
}

config_dunst() {
	mkdir -p ~/.config/dunst
	replace dunst/dunstrc ~/.config/dunst/dunstrc

	# dunst is started by systemd, need to play these in
	# ~/bin since it's one of the few directories in path
	cp bin/play-success-sound ~/bin/play-success-sound
	sed -i "s|\\\$DOTFILES|$DOTFILES|g" ~/bin/play-success-sound

	cp bin/play-fail-sound ~/bin/play-fail-sound
	sed -i "s|\\\$DOTFILES|$DOTFILES|g" ~/bin/play-fail-sound
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

perform_install() {
	echo Creating default ~/.bashrc
	if [ -e /c ]; then
		windows_install
	elif [ "$(uname)" = "Darwin" ]; then
		mac_install
	else
		linux_install
	fi

	replace inputrc "$HOME/.inputrc"

	./configure_git_defaults.sh
}

windows_install() {
	add_bashrc_source bashrc_win ~/.bashrc
}

mac_install() {
	add_bashrc_source bashrc ~/.bashrc
	add_bashrc_source bashrc ~/.bash_profile

	config_tmux

	read -p 'Hit enter to launch solarized terminal, then click Shell > Use Settings as Default'
	open osx-terminal/solarized-dark.terminal
}

linux_install() {
	add_bashrc_source bashrc ~/.bashrc

	if [ -d /etc/regolith ]; then
		echo Regolith detected: skipping colour configuration
	else
		### enable solarized for gnome
		$DOTFILES/gnome/solarized.sh dark
	fi

	config_tmux
	config_i3
	config_dunst

	replace Xresources ~/.Xresources
	replace alacritty.yml

	echo Adding apt-install to /bin
	APT_INSTALL="/bin/apt-install"
	[ -e $APT_INSTALL ] || sudo ln -s $DOTFILES/bin/apt-install $APT_INSTALL
}

perform_install
