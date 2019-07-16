#!/bin/sh

ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
