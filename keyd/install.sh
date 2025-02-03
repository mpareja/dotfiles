#!/bin/bash

set -euo pipefail

cd $(mktemp -d)
pwd

git clone https://github.com/rvaiya/keyd .
make && sudo make install
sudo systemctl enable keyd && sudo systemctl start keyd

sudo cp "$DOTFILES/keyd/keyd.conf" /etc/keyd/default.conf

