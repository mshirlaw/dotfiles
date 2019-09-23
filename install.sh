#!/bin/sh

ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.ackrc ~/.ackrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
