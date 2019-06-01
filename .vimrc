" mshirlaw
" 1 June 2019

" required by vundle package manager
set nocompatible
filetype off

if isdirectory($HOME . "/Documents/accelo/affinitylive")
	cd $HOME/Documents/accelo/affinitylive
endif

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/after/
set rtp+=/usr/local/opt/fzf

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'mshirlaw/jira-prepend'
Plugin 'mshirlaw/remote-compile'
Plugin 'junegunn/fzf.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'w0rp/ale'
call vundle#end()

filetype plugin on

" custom settings
syntax enable

" colours
colorscheme skyhawk
hi Search cterm=bold gui=bold

set number
set relativenumber
set autoindent
set nosmartindent
set nocindent
set ts=4 sw=4 

set softtabstop=0 noexpandtab

set mouse=a
set binary
set noeol
set hlsearch incsearch
set ignorecase

set cursorline
set path=$PWD/**
set backspace=indent,eol,start
set wildmenu
set redrawtime=10000
set laststatus=2

set wrap!
set hidden
set tags=tags

" set .tt file type to html
augroup tt_as_html
	autocmd!
	autocmd BufNewFile,BufRead *.tt set filetype=html
augroup END

" syntax highlighting from the start always
augroup syntax_highlight
	autocmd!
	autocmd BufEnter * :syntax sync fromstart
augroup END

" use relative line numbers for NERDTree
augroup nerd_tree
	autocmd FileType nerdtree setlocal relativenumber
augroup END

" set custom leader key
let mapleader = ","

" visual mode key mappings, git blame (selected lines) format as json (selected lines), perltidy selection
vnoremap <leader>td :!perltidy<cr>
vnoremap <leader>js :!python -m json.tool<cr>

" normal mode key mappings, git blame (single line), ctrl-p, find, perltidy whole file, perlcritic, format as json (whole file)
nnoremap <leader>ff :Files<cr>
nnoremap <leader>bb :Buffers<cr>
nnoremap <leader>ag :Ag<cr>
nnoremap <leader>td :%!perltidy<cr>
nnoremap <leader>cr <esc>:compiler perlcritic<bar>:make<cr><bar>:cope<cr>
nnoremap <leader>js :%!python -m json.tool<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" nnoremap <left> <nop>
" nnoremap <down> <nop>
" nnoremap <up> <nop>
" nnoremap <right> <nop>

nnoremap <c-]> :execute "tjump " . expand("<cword>")<cr>

map <c-n> :NERDTreeToggle<cr>

" plugin globals

let NERDTreeShowLineNumbers=1
let g:NERDTreeNodeDelimiter = "\u00a0"

let g:jira_prepend_ticket_pattern="AFFINITY"
let g:jira_prepend_custom_message="#time "
let g:remote_compile_project_dir="/Users/mshirlaw/Documents/accelo/affinitylive/"

let g:fzf_layout = { 'down': '~20%' }
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

let g:airline_theme='tomorrow'

" ale linter

let g:airline#extensions#ale#enabled=1

let g:ale_sign_error = '>>'
let g:ale_sign_warning = '>>'
let g:ale_set_highlights=1

let g:ale_linters_explicit=1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'perl' : ['perlcritic'],
\}

