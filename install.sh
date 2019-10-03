#!/bin/sh

# setup sym links 
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/dotfiles/.ackrc ~/.ackrc
ln -s ~/dotfiles/.zshrc ~/.zshrc

# install required software

# vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# vim plugins
vim +PluginInstall +qall

# oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
