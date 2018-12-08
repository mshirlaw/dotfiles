" mshirlaw
" 8 December 2018

" required by vundle package manager
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/after/

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
call vundle#end()

"filetype plugin indent on
"filetype plugin indent off
filetype plugin on

" custom settings
syntax enable

" colours
colorscheme skyhawk

set number
set autoindent
set nosmartindent
set nocindent
set ts=4 sw=4 
set noexpandtab
set mouse=a
set binary
set noeol
set incsearch
set ignorecase
set cursorline
set path=$PWD/**
set backspace=indent,eol,start
set wildmenu
set redrawtime=10000

" set .tt file type to html
au BufNewFile,BufRead *.tt set filetype=html

" syntax highlighting from the start always
autocmd BufEnter * :syntax sync fromstart

" set custom leader key
let mapleader = ","

" visual mode key mappings, git blame (selected lines) format as json (selected lines), perltidy selection
vnoremap <leader>b :<C-U>execute ":!git blame -L " . line("'<") . "," . line("'>") . " " . "%"<CR>
vnoremap <leader>j :!python -m json.tool<CR>
vnoremap <leader>t :!perltidy<CR>

" normal mode key mappings, git blame (single line), ctrl-p, find, perltidy whole file, perlcritic, format as json (whole file)
nnoremap <leader>b :<C-U>execute ":!git blame -L " . line(".") . "," . line(".") . " " . "%"<CR>
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>f :Ack! 
nnoremap <leader>t :%!perltidy<CR>
nnoremap <leader>c <ESC>:compiler perlcritic<bar>:make<CR><bar>:cope<CR>
nnoremap <leader>j :%!python -m json.tool<CR>

" ctrl-p
let g:ctrlp_max_files=0

