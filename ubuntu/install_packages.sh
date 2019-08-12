#!/bin/bash

echo adding i3wm keyring required to avoid insecure repository warnings...
/usr/lib/apt/apt-helper download-file http://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2019.02.01_all.deb /tmp/keyring.deb SHA256:176af52de1a976f103f9809920d80d02411ac5e763f695327de9fa6aff23f416
dpkg -i /tmp/keyring.deb

echo ======= Adding external repositories...
add-apt-repository "deb http://debian.sur5r.net/i3/ $(lsb_release -sc) universe" # i3wm
add-apt-repository -y ppa:gwendal-lebihan-dev/hexchat-stable # HEXCHAT
add-apt-repository -y ppa:synapse-core/testing # SYNAPSE (not found in Ubuntu 14.04)

echo ======= Installing packages...
apt-get update
xargs apt-get install -y < packages
