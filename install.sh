#!/bin/bash
DotFiles=$(pwd)

replace () {
	target="$HOME/.$1"
	[ -e $target ] && rm $target
	ln "$DotFiles/$1" $target
}

echo Creating default ~/.bashrc
if [ -e /c ]; then
	# windows
	echo ". $DotFiles/bashrc_win" > ~/.bashrc
else
	echo ". $DotFiles/bashrc" > ~/.bashrc
	$DotFiles/gnome/solarized.sh dark

	replace tmux.conf
	replace tmuxcolors.conf
fi

./configure_git_defaults.sh
