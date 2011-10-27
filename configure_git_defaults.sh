#!/bin/sh
git config --global user.name "Mario Pareja"
git config --global user.email "pareja.mario@gmail.com"
git config --global core.autocrlf false
git config --global core.editor gvim
git config --global core.pager "less -q -x4"
git config --global color.ui auto
git config --global log.date relative

if [ -e /c ]; then
  echo "Using DiffMerge for windows"
  git config --global diff.tool diffmerge
  git config --global difftool.prompt false
  git config --global difftool.diffmerge.cmd 'c:/profiles/mpareja/Desktop/Dropbox/command_line_tools/gitextdiff.sh "$LOCAL" "$REMOTE"'
fi
