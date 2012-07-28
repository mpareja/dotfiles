#!/bin/sh
echo Configuring git defaults
git config --global user.name "Mario Pareja"
git config --global user.email "pareja.mario@gmail.com"
git config --global core.autocrlf false
git config --global core.editor vim
git config --global core.pager "less -q -x4"
git config --global color.ui auto
git config --global log.date relative
git config --global diff.renames copies

git config --global alias.ca "commit --amend -C HEAD"

# Borrowed from: http://www.jukie.net/bart/blog/pimping-out-git-log
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

git config --global guitool.gvim.cmd 'gvim "$FILENAME"'
git config --global guitool.gvim.noconsole yes
git config --global guitool."delete file".cmd 'rm $FILENAME'
git config --global guitool."delete file".noconsole yes
git config --global guitool."delete file".confirm yes
git config --global guitool.difftool.cmd 'git difftool -- "$FILENAME"'
git config --global guitool.difftool.noconsole yes
git config --global guitool."difftool staged".cmd 'git difftool --staged -- "$FILENAME"'
git config --global guitool."difftool staged".noconsole yes

if [ -e /c ]; then
  echo "Using DiffMerge for windows"
  git config --global diff.tool diffmerge
  git config --global difftool.prompt false

  Tool=$DOTFILES/winbin/gitextdiff.sh
  ToolDrive=${Tool:1:1}
  ToolPath=${Tool:2}
  DIFF=$(echo $ToolDrive:$ToolPath \"\$LOCAL\" \"\$REMOTE\")

  git config --global difftool.diffmerge.cmd "$DIFF"

  echo "Including TFS Checkin git gui tool"
  git config --global guitool."TFS Checkin".cmd tfscheckin
fi
