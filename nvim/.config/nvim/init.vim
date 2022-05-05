" 4 May 2022 
" init.vim
" Matt Shirlaw

" plugins

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim 
	    \ --create-dirs 
	    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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

    " theme
    Plug 'haishanh/night-owl.vim'
    Plug 'itchyny/lightline.vim'

    " fzf
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
 
    " nvmim tree
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'

    " git 
    Plug 'tpope/vim-fugitive'

    " formatting
    Plug 'tpope/vim-commentary'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

    " autopairs
    Plug 'windwp/nvim-autopairs'

    " js / jsx 
    Plug 'maxmellon/vim-jsx-pretty'  
    Plug 'pangloss/vim-javascript'  
    Plug 'alvan/vim-closetag'

call plug#end()

" syntax highlighting and color scheme

if (has("termguicolors"))
    set termguicolors
endif

augroup syntax_highlight
	autocmd!
	autocmd BufEnter * :syntax sync fromstart
augroup END

if !exists('g:loaded_color')
  let g:loaded_color = 1
  colorscheme night-owl
endif

" general settings

set autoindent
set backspace=indent,eol,start
set binary
set clipboard^=unnamed,unnamedplus
set completeopt=menu,menuone,noselect
set cursorline
set encoding=UTF-8
set hidden
set ignorecase
set incsearch
set laststatus=2
set mouse=a
set nocindent
set nocompatible
set noeol
set nohlsearch
set nosmartindent
set number
set path=$PWD/**
set redrawtime=10000
set relativenumber
set splitbelow
set splitright
set termguicolors
set ts=4 sw=4 expandtab
set wildmenu
set wrap!

" set directory for tmp files

if isdirectory($HOME . '/.tmp')
	set directory=$HOME/.tmp
endif

" cursor shape

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

" plugin specific lua settings 

luafile $HOME/.config/nvim/nvim-tree/config.lua
luafile $HOME/.config/nvim/nvim-telescope/config.lua
luafile $HOME/.config/nvim/nvim-lspconfig/config.lua
luafile $HOME/.config/nvim/nvim-cmp/config.lua

" plugin specific vim settings

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'highlight': 'Comment' } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:40%' --layout reverse --margin=1,4"
let g:fzf_colors = {
	\ 'fg':      ['fg', 'Normal'],
	\ 'bg':      ['bg', 'Normal'],
	\ 'hl':      ['fg', 'Comment'],
	\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+':     ['fg', 'Statement'],
	\ 'info':    ['fg', 'PreProc'],
	\ 'border':  ['fg', 'Ignore'],
	\ 'prompt':  ['fg', 'Conditional'],
	\ 'pointer': ['fg', 'Exception'],
	\ 'marker':  ['fg', 'Keyword'],
	\ 'spinner': ['fg', 'Label'],
	\ 'header':  ['fg', 'Comment'] }

let g:lightline = { 'colorscheme': 'nightowl' }

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1
let g:prettier#exec_cmd_async = 1

" javascript / jsx

let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0

let g:closetag_filenames = '*.tsx,*.xhtml,*.html'
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ 'typescriptreact': 'jsxRegion,tsxRegion',
    \ 'javascriptreact': 'jsxRegion',
    \ }

" autopairs

lua << EOF
require('nvim-autopairs').setup{}
EOF

" key bindings

lua require("mshirlaw")

let mapleader = ","

" visual mode key mappings

vnoremap <leader>js :!python -m json.tool<cr>
vnoremap < <gv
vnoremap > >gv

" copy file paths

nnoremap <leader>yp :let @*=expand("%:p")<cr>
nnoremap <leader>yd :let @*=@%<cr>

" format json

nnoremap <leader>js :%!python -m json.tool<cr>

" working with .vimrc

nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>fv :lua require("mshirlaw.telescope").search_dotfiles()<cr>
nnoremap <leader>fn :lua require("mshirlaw.telescope").search_notes()<cr>

" highlight all

nnoremap <leader>ha ggVG

" window switching

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" alternative buffer switching

nnoremap <TAB> :bn<cr>
nnoremap <S-TAB> :bp<cr>
nnoremap <S-DOWN> :bw!<cr>

" find files using telescope

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" nvim tree

map <c-n>t ::NvimTreeToggle<cr>
nnoremap <c-n>f :NvimTreeFindFile<cr>

"git fugitive

nmap <leader>gs :G<CR>
nmap <leader>gf :Gdiffsplit<cr>
nmap <leader>gb :Git blame<cr>