#!/bin/bash
DotFiles=$(pwd)

echo Creating default ~/.bashrc
if [ -e /c ]; then
	# windows
	echo ". $DotFiles/bashrc_win" > ~/.bashrc
else
	ln $DotFiles/bashrc ~/.bashrc
	$DotFiles/gnome/solarized.sh dark

	ln $DotFiles/tmuxcolors.conf ~/.tmuxcolors.conf
fi

./configure_git_defaults.sh
