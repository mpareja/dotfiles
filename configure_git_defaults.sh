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

  DROPBOX=/c/profiles/mpareja/Desktop/Dropbox/command_line_tools/gitextdiff.sh
  if [ ! -e "$DROPBOX" ]; then DROPBOX=/d/profiles/mpareja/Desktop/reference/command_line_tools/gitextdiff.sh; fi

  DBDrive=${DROPBOX:1:1}
  DBPath=${DROPBOX:2}
  DIFF=$(echo $DBDrive:$DBPath \"\$LOCAL\" \"\$REMOTE\")

  git config --global difftool.diffmerge.cmd "$DIFF"
fi
