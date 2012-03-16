#!/bin/sh
echo Configuring git defaults
git config --global user.name "Mario Pareja"
git config --global user.email "pareja.mario@gmail.com"
git config --global core.autocrlf false
git config --global core.editor vim
git config --global core.pager "less -q -x4"
git config --global color.ui auto
git config --global log.date relative

if [ -e /c ]; then
  echo "Using DiffMerge for windows"
  git config --global diff.tool diffmerge
  git config --global difftool.prompt false

  Tool=$DOTFILES/winbin/gitextdiff.sh
  ToolDrive=${Tool:1:1}
  ToolPath=${Tool:2}
  DIFF=$(echo $ToolDrive:$ToolPath \"\$LOCAL\" \"\$REMOTE\")

  git config --global difftool.diffmerge.cmd "$DIFF"
fi
