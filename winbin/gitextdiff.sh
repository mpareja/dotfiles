#!/bin/sh
if [ "$1" = '--install' ]; then
	echo "Installing external diff tool"
	git config --global difftool.diffmerge.cmd "$0 \"\$LOCAL\" \"\$REMOTE\""
	git config --global diff.tool diffmerge
	exit 0
fi

DIFF=/d/programs/development/diffmerge/DiffMerge.exe
if [ ! -e "$DIFF" ]; then DIFF="$PROGRAMFILES/SourceGear/DiffMerge/DiffMerge.exe"; fi
if [ ! -e "$DIFF" ]; then DIFF="$PROGRAMFILES/SourceGear/Common/DiffMerge/sgdm.exe"; fi
if [ ! -e "$DIFF" ]; then DIFF="/c/Program Files/SourceGear/Common/DiffMerge/sgdm.exe"; fi
if [ ! -e "$DIFF" ]; then DIFF=/e/programs/development/diffmerge/DiffMerge.exe; fi
if [ ! -e "$DIFF" ]; then DIFF="$PROGRAMFILES (x86)/SourceGear/DiffMerge/DiffMerge.exe"; fi

if [ ! -e "$DIFF" ]; then
	echo "DiffMerge not found!"
	exit 1
fi

"$DIFF" //title1="Old Version" "$1" //title2="New Version" "$2"

