#!/bin/sh
DotFiles=$(pwd)

echo Creating default ~/.bashrc
echo ". $DotFiles/bashrc_win" > ~/.bashrc

./configure_git_defaults.sh
