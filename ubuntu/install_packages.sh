#!/bin/bash

echo adding i3wm keyring required to avoid insecure repository warnings...
i3keyring=$(mktemp)
/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2019.02.01_all.deb $i3keyring SHA256:176af52de1a976f103f9809920d80d02411ac5e763f695327de9fa6aff23f416
dpkg -i $i3keyring

echo ======= Adding external repositories...
echo "deb https://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" > /etc/apt/sources.list.d/sur5r-i3.list

echo ======= Installing packages...
apt-get update
xargs apt-get install -y < packages

# pin version of notify-osd with timeout support
apt-mark hold notify-osd
