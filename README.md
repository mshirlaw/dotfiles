## Dotfiles

Custom settings for various editors and new machine setup

### Config

This repository currently provides configuration for 

* vim
* nvim
* tmux
* ack
* vscode

### Required software

* brew (mac only)
* iterm 2 (mac only)
* vim 
* nvim
* ripgrep
* fzf
* tmux
* ag (the silver searcher)
* oh-my-zsh
* bat

### Symlinks

To setup these dotfiles there are a number of symlinks to create:

### vim

    ln -s $HOME/dotfiles/vim $HOME/.vim
    ln -s $HOME/dotfiles/vim/.vimrc $HOME/.vimrc

### nvim

    ln -s $HOME/dotfiles/nvim/ $HOME/.config/nvim

### tmux

    ln -s $HOME/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf
