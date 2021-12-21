" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim 
	    \ --create-dirs 
	    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    "autocmd VimEnter * PlugInstall
    "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " lsp & completion
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " snippets
    Plug 'SirVer/ultisnips'
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    " nvim-telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " nvim-treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " theme
    Plug 'haishanh/night-owl.vim'
    Plug 'itchyny/lightline.vim'

    " fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " nerdtree
"    Plug 'ryanoasis/vim-devicons'
"    Plug 'scrooloose/nerdtree'
 
    " nvmim tree
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'

    " git 
    Plug 'tpope/vim-fugitive'

    " formatting
    Plug 'tpope/vim-commentary'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

    " lsp
"    Plug 'neovim/nvim-lspconfig'
"    Plug 'glepnir/lspsaga.nvim'
"    Plug 'hrsh7th/nvim-compe'

    " run tests
 "   Plug 'vim-test/vim-test'

    " which key
    Plug 'folke/which-key.nvim'

call plug#end()