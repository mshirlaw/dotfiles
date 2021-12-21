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


