#!/bin/sh

UNAME_STRING="$(uname -s)"

case "${UNAME_STRING}" in
	Linux*)		OPERATING_SYSTEM=linux;;
    Darwin*)	OPERATING_SYSTEM=mac;;
    *)			OPERATING_SYSTEM="UNKNOWN:${UNAME_STRING}"
esac

cd $HOME

# setup symlinks for vim
ln -s $HOME/dotfiles/vim $HOME/.vim
ln -s $HOME/dotfiles/vim/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/vim/.ideavimrc $HOME/.ideavimrc

# setup symlinks for nvim
ln -s $HOME/dotfiles/nvim $HOME/.config/nvim

# setup symlinks for tmux
ln -s $HOME/dotfiles/tmux/.tmux.conf $HOME/.tmux.conf

# setup symlinks for ack
ln -s $HOME/dotfiles/.ackrc $HOME/.ackrc

# setup symlinks for ignore files
ln -s $HOME/dotfiles/.ignore $HOME/.ignore

if [[ "$OPERATING_SYSTEM" == "linux" ]];
then
    ln -s $HOME/dotfiles/vscode/settings.json $HOME/.config/Code/User/settings.json
    ln -s $HOME/dotfiles/vscode/keybindings.json $HOME/.config/Code/User/keybindings.json
    ln -s $HOME/dotfiles/vscode/snippets $HOME/.config/Code/User/snippets
elif [[ "$OPERATING_SYSTEM" == "mac" ]]
then
    ln -s $HOME/dotfiles/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
    ln -s $HOME/dotfiles/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
    ln -s $HOME/dotfiles/vscode/snippets $HOME/Library/Application\ Support/Code/User/snippets
fi

# install oh my zsh & zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/dracula/zsh.git $HOME/zsh
ln -s $HOME/zsh/dracula.zsh-theme $HOME/.oh-my-zsh/themes/dracula.zsh-theme
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc

# install brew on mac

# install iterm2 on mac

# install nvim 

# install ripgrep 

# install fzf

# install tmux

# install ag (the silver searcher)

# install bat


