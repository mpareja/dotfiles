#!/bin/bash

echo ======= Installing packages...
apt-get update
xargs apt-get install -y < packages

# pin version of notify-osd with timeout support
apt-mark hold notify-osd
