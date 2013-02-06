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
git config --global push.default upstream

git config --global alias.ca "commit --amend -C HEAD"

# Borrowed from: http://www.jukie.net/bart/blog/pimping-out-git-log
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold cyan)<%an>%Creset' --abbrev-commit --date=relative"

git config --global guitool."Delete File...".cmd 'rm $FILENAME'
git config --global guitool."Delete File...".noconsole yes
git config --global guitool."Delete File...".confirm yes
git config --global guitool."Pull Latest Changes from GitHub".cmd "$(pwd)/bin/gpull"
git config --global guitool."Pull Latest Changes from GitHub".confirm no
git config --global guitool."Push Committed Changes to GitHub".cmd "$(pwd)/bin/gpush"
git config --global guitool."Push Committed Changes to GitHub".confirm yes
git config --global guitool."Open File in Editor".cmd 'gvim "$FILENAME"'
git config --global guitool."Open File in Editor".noconsole yes
git config --global guitool."View Changes Externally".cmd 'git difftool -- "$FILENAME"'
git config --global guitool."View Changes Externally".noconsole yes
git config --global guitool."View Staged Changes Externally".cmd 'git difftool --staged -- "$FILENAME"'
git config --global guitool."View Staged Changes Externally".noconsole yes

if [ -e /c ]; then
  echo "Using Windows Credential Store"
  git config --global credential.helper wincred

  echo "Using DiffMerge for windows"
  git config --global diff.tool diffmerge
  git config --global difftool.prompt false

  Tool=$(pwd)/winbin/gitextdiff.sh
  ToolDrive=${Tool:1:1}
  ToolPath=${Tool:2}
  DIFF=$(echo $ToolDrive:$ToolPath \"\$LOCAL\" \"\$REMOTE\")

  git config --global difftool.diffmerge.cmd "$DIFF"
fi
