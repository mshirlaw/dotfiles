" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim 
	    \ --create-dirs 
	    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall
    "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " nvim-telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " theme
    Plug 'haishanh/night-owl.vim'
    Plug 'itchyny/lightline.vim'

    " fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " nerdtree
    Plug 'ryanoasis/vim-devicons'
    Plug 'scrooloose/nerdtree'
    
    " git 
    Plug 'tpope/vim-fugitive'

    " formatting
    Plug 'tpope/vim-commentary'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

    " lsp
    Plug 'neovim/nvim-lspconfig'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'hrsh7th/nvim-compe'
    
    " syntax
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()