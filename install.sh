#!/bin/sh

UNAME_STRING="$(uname -s)"

case "${UNAME_STRING}" in
	Linux*)		OPERATING_SYSTEM=linux;;
    Darwin*)	OPERATING_SYSTEM=mac;;
    *)			OPERATING_SYSTEM="UNKNOWN:${UNAME_STRING}"
esac

cd $HOME

# setup symlinks 
ln -s $HOME/dotfiles/vim $HOME/.vim
ln -s $HOME/dotfiles/.vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/.ideavimrc $HOME/.ideavimrc
ln -s $HOME/dotfiles/.ackrc $HOME/.ackrc
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

# setup oh my zsh & zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/dracula/zsh.git $HOME/zsh
ln -s $HOME/zsh/dracula.zsh-theme $HOME/.oh-my-zsh/themes/dracula.zsh-theme
ln -s $HOME/dotfiles/.zshrc $HOME/.zshrc

# setup vundle / vim
git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


