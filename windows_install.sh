#!/bin/sh
DotFiles=$(pwd)

echo ". $DotFiles/bashrc_win" > ~/.bashrc

./configure_git_defaults.sh
