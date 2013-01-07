#!/bin/sh
DIFF=/d/programs/development/diffmerge/DiffMerge.exe
if [ ! -e "$DIFF" ]; then DIFF="$PROGRAMFILES/SourceGear/DiffMerge/DiffMerge.exe"; fi
if [ ! -e "$DIFF" ]; then DIFF="$PROGRAMFILES/SourceGear/Common/DiffMerge/sgdm.exe"; fi
if [ ! -e "$DIFF" ]; then DIFF="$PROGRAMFILES (x86)/SourceGear/DiffMerge/DiffMerge.exe"; fi
if [ ! -e "$DIFF" ]; then DIFF="$PROGRAMFILES (x86)/SourceGear/Common/DiffMerge/sgdm.exe"; fi
if [ ! -e "$DIFF" ]; then DIFF="/d/Program Files/SourceGear/Common/DiffMerge/sgdm.exe"; fi
if [ ! -e "$DIFF" ]; then DIFF="/d/Program Files (x86)/SourceGear/Common/DiffMerge/sgdm.exe"; fi
if [ ! -e "$DIFF" ]; then DIFF=/c/programs/development/diffmerge/DiffMerge.exe; fi
if [ ! -e "$DIFF" ]; then DIFF=/d/programs/development/diffmerge/DiffMerge.exe; fi
if [ ! -e "$DIFF" ]; then DIFF=/e/programs/development/diffmerge/DiffMerge.exe; fi

if [ ! -e "$DIFF" ]; then
	echo "DiffMerge not found!"
	exit 1
fi

"$DIFF" //title1="Old Version" "$1" //title2="New Version" "$2"

