#!/bin/bash

echo ======= Adding Regolith PPA
add-apt-repository ppa:regolith-linux/release

echo ======= Installing packages...
apt-get update
xargs apt-get install -y < packages

# pin version of notify-osd with timeout support
apt-mark hold notify-osd
