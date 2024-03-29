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

is_regolith_1() {
  grep '=1' /etc/regolith/version 2>&1 >/dev/null
}

is_regolith_2() {
  grep '=2' /etc/regolith/version 2>&1 >/dev/null
}

config_i3() {
	echo Replacing i3 window manager configuration

	cd i3

  if is_regolith_1; then
    mkdir -p ~/.config/regolith/i3

    replace config ~/.config/regolith/i3/config
  elif is_regolith_2; then
    mkdir -p ~/.config/regolith2/i3/config.d
    mkdir -p ~/.config/regolith2/picom

    replace regolith-addon-config ~/.config/regolith2/i3/config.d/regolith-addon-config
    replace picom.conf ~/.config/regolith2/picom/config
    replace Xresources ~/.config/regolith2/Xresources
    xrdb merge ~/.config/regolith2/Xresources
  else
    mkdir -p ~/.config/regolith3/common-wm/config.d
    mkdir -p ~/.config/regolith3/picom

    replace regolith-addon-config ~/.config/regolith3/common-wm/config.d/regolith-addon-config
    replace picom.conf ~/.config/regolith3/picom/config
    replace Xresources ~/.config/regolith3/Xresources
    xrdb merge ~/.config/regolith3/Xresources
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

	replace alacritty.yml

	echo Adding apt-install to /bin
	APT_INSTALL="/bin/apt-install"
	[ -e $APT_INSTALL ] || sudo ln -s $DOTFILES/bin/apt-install $APT_INSTALL
}

perform_install
