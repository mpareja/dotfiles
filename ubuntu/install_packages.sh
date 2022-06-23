#!/bin/bash

echo ======= Adding Regolith PPA
if [ ! -f /etc/apt/sources.list.d/regolith.list ]; then
  wget -qO - https://regolith-desktop.io/regolith.key | gpg --dearmor | sudo tee /usr/share/keyrings/regolith-archive-keyring.gpg
  echo deb "[arch=amd64 signed-by=/usr/share/keyrings/regolith-archive-keyring.gpg] https://regolith-desktop.io/release-ubuntu-jammy-amd64 jammy main" | \
    sudo tee /etc/apt/sources.list.d/regolith.list
fi

echo ======= Installing packages...
apt-get update
xargs apt-get install -y < packages

# pin version of notify-osd with timeout support
apt-mark hold notify-osd
