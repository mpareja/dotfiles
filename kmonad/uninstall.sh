#!/bin/bash

set -eou pipefail

safe_grep() {
  grep "$@" || true
}

kmonad_uninstall() {
  # make script idempotent by using safe_grep to ignore errors
  # when we don't find a systemd kmonad service
  systemctl | safe_grep kmonad- | awk '{ print $1 }' | while read service; do
    echo "Uninstalling kmonad service '$service'..."

    sudo systemctl stop $service
    sudo systemctl disable $service

    sudo rm -f /usr/lib/systemd/system/$service;
  done

  sudo rm -f /usr/bin/kmonad
  sudo rm -rf /usr/share/kmonad
}

kmonad_uninstall
