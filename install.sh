#!/bin/sh

# install oh my zsh

echo "INFO:  Installing oh-my-zsh"
echo

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/dracula/zsh.git $HOME/dotfiles/zsh
ln -s $HOME/dotfiles/zsh/dracula.zsh-theme $HOME/.oh-my-zsh/themes/dracula.zsh-theme

# install homebrew on mac

echo "INFO:  Installing Homebrew"
echo

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install alacritty on mac

echo "INFO:  Installing alacritty"
echo

brew install --cask alacritty

# install neovim 

echo "INFO:  Installing neovim"
echo

brew install neovim

# install ripgrep

echo "INFO:  Installing ripgrep"
echo

brew install ripgrep

# install fzf

echo "INFO:  Installing fzf"
echo

brew install fzf

# install tmux

echo "INFO:  Installing tmux"
echo

brew install tmux

# install gnu stow

echo "INFO:  Installing stow"
echo

brew install stow

# change into dotfiles dir
cd $HOME/dotfiles || exit

# stow all config

echo "INFO:  Settimg up config directorie"
echo

stow alacritty
stow nvim
stow tmux
stow zsh

