#!/bin/bash

set -eou pipefail

kbd_inputs() {
  find /dev/input/by-path -name '*-kbd'
}

kmonad_install() {
  if [ -f kmonad ]; then
    echo "kmonad: found binary, skipping compilation"
    echo
  else
    echo "kmonad: building from scratch!"
    echo
    docker build -t kmonad-builder github.com/kmonad/kmonad.git

    docker run --rm -it -v ${PWD}:/host/ kmonad-builder bash -c 'cp -vp /root/.local/bin/kmonad /host/'

    docker rmi kmonad-builder
  fi

  sudo install -m755 kmonad /usr/bin/

  kbd_inputs | while read kbdpath; do
    kbd=$(basename $kbdpath)
    echo "Installing kmonad for device '$kbd'..."

    sudo install -Dm644 config.kbd.txt /usr/share/kmonad/config-$kbd.kbd.txt
    sudo sed -i "s|REPLACE_DEVICE|$kbdpath|" /usr/share/kmonad/config-$kbd.kbd.txt

    sudo install -Dm644 kmonad.service /usr/lib/systemd/system/kmonad-$kbd.service;
    sudo sed -i "s/REPLACE_DEVICE/$kbd/" /usr/lib/systemd/system/kmonad-$kbd.service;

    sudo systemctl enable kmonad-$kbd
    sudo systemctl restart kmonad-$kbd
  done
}

./uninstall.sh
kmonad_install
