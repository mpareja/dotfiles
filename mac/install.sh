#!/bin/bash

. ../ubuntu/functions
. ../ubuntu/config

header Installing and configuring machine...

xargs brew install < brew-packages
xargs brew cask install < brew-cask-packages

github
dotfiles
vim
