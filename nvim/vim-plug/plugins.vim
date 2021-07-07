" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim 
	\ --create-dirs 
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

	Plug 'haishanh/night-owl.vim'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
	Plug 'ryanoasis/vim-devicons'
	Plug 'scrooloose/nerdtree'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-fugitive'
    Plug 'itchyny/lightline.vim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'

call plug#end()