#!/bin/bash
DotFiles=$(pwd)

echo Creating default ~/.bashrc
if [ -e /c ]; then
	# windows
	echo ". $DotFiles/bashrc_win" > ~/.bashrc
else
	echo ". $DotFiles/bashrc" > ~/.bashrc
	$DotFiles/gnome/solarized.sh dark
fi

./configure_git_defaults.sh
