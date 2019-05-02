#!/bin/sh

DBPATH=~/Dropbox/github/dotfiles

cp -r ~/.vim/ $DBPATH/vim/
cp ~/.vimrc $DBPATH/.vimrc
cp ~/.gvimrc $DBPATH/.gvimrc
cp ~/.ackrc $DBPATH/.ackrc

sudo rm -r $DBPATH/vim/*/*/.git

git add .
git commit