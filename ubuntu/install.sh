#!/bin/bash

. ./functions
. ./config

header Installing and configuring machine...

sudo ./install_packages.sh

chrome
github
dotfiles
vim

