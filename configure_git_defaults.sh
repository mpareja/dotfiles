#!/bin/sh
echo Configuring git defaults

FullName=$(git config --global user.name)
if [ -z "$FullName" ]; then
	read -p 'Enter Full Name: ' FullName
fi

Email=$(git config --global user.email)
if [ -z "$Email" ]; then
	read -p 'Enter Email Address: ' Email
fi

git config --global user.name "$FullName"
git config --global user.email "$Email"
git config --global core.autocrlf false
git config --global core.editor vim
git config --global core.pager "less -q -x4"
git config --global color.ui auto
git config --global log.date relative
git config --global diff.renames copies
git config --global push.default upstream
git config --global branch.autoSetupRebase always

git config --global alias.ca "commit --amend -C HEAD"

# Borrowed from: http://www.jukie.net/bart/blog/pimping-out-git-log
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold cyan)<%an>%Creset' --abbrev-commit --date=relative"

git config --global gui.gcwarning false
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
git config --global guitool."Fix Trailing Whitespace on Staged File".cmd "$(pwd)/bin/fixtrailingwhitespace \" \$FILENAME\""
git config --global guitool."Fix Trailing Whitespace on Staged File".noconsole yes

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
else
  echo "Using Cache Credential Store (4 hour cached password)"
  git config --global credential.helper "cache --timeout 14400"

  if hash meld 2>/dev/null; then
    echo "Using Meld as diff tool"
    git config --global diff.tool meld
    git config --global difftool.prompt false
  fi
fi
