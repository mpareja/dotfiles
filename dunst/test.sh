#!/bin/sh

pkill dunst
dunst &

notify-send some_summary "tests passed"

sleep 1

notify-send some_summary "tests failed"

sleep 1

ustatus echo working

# test duplicates (no stacking to enable sounds)
sleep 0.3 && ustatus echo working
sleep 0.3 && ustatus echo working
sleep 0.3 && ustatus echo working

sleep 1

ustatus invalidcommandthatweran
