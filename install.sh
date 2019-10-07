#!/bin/sh

cd ~

# setup symlinks 
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.ideavimrc ~/.ideavimrc
ln -s ~/dotfiles/.ackrc ~/.ackrc

# setup oh my zsh & zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/dracula/zsh.git ~/zsh
ln -s ~/zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
ln -s ~/dotfiles/.zshrc ~/.zshrc

# setup vundle / vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

