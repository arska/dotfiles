#!/usr/bin/env bash

RSYNCCMD="rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
      --exclude "README.md" --exclude "LICENSE-MIT.txt" -avh --no-perms . ~"

cd "$(dirname "${BASH_SOURCE}")";

#git pull origin master;

function diffIt() {
  FILES=$($RSYNCCMD -n | grep -v "building file list" | grep -v "sent .* bytes" | grep -v "total size is ") #run in dry-run mode and list the files
  for f in $FILES; do
    if [ -f "$f" ] ; then
      diff -urN ./$f ~/$f
    fi
  done
}

function doIt() {
  $RSYNCCMD
  source ~/.bash_profile;
  # bootstrap vim neobundle
  if [ ! -d ~/.vim/bundle/neobundle.vim ] ; then
    NEOBUNDLE=$(mktemp /tmp/dotfiles.XXXXXX)
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > $NEOBUNDLE
    sh $NEOBUNDLE
    rm $NEOBUNDLE
  fi
}

if [ "$1" == "--diff" -o "$1" == "-d" ]; then
  diffIt;
elif [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset RSYNCCMD;
unset doIt;
unset diffIt;
