" mshirlaw
" 16 December 2018

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

filetype plugin on

" custom settings
syntax enable

" colours
colorscheme skyhawk
hi Search cterm=bold gui=bold

set number
set autoindent
set nosmartindent
set nocindent
set ts=4 sw=4 
set noexpandtab
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

" set .tt file type to html
au BufNewFile,BufRead *.tt set filetype=html

" syntax highlighting from the start always
autocmd BufEnter * :syntax sync fromstart

" set custom leader key
let mapleader = ","

" visual mode key mappings, git blame (selected lines) format as json (selected lines), perltidy selection
vnoremap <leader>b :<c-u>execute ":!git blame -L " . line("'<") . "," . line("'>") . " " . "%"<cr>
vnoremap <leader>j :!python -m json.tool<cr>
vnoremap <leader>t :!perltidy<cr>

" normal mode key mappings, git blame (single line), ctrl-p, find, perltidy whole file, perlcritic, format as json (whole file)
nnoremap <leader>b :<c-u>execute ":!git blame -L " . line(".") . "," . line(".") . " " . "%"<cr>
nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>f :Ack! 
nnoremap <leader>t :%!perltidy<cr>
nnoremap <leader>cr <esc>:compiler perlcritic<bar>:make<cr><bar>:cope<cr>
nnoremap <leader>j :%!python -m json.tool<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>

" ctrl-p
let g:ctrlp_max_files=0

" build compile perl script on vbox

let g:affinity_working_directory="/Users/mshirlaw/Documents/accelo/affinitylive/"

augroup affinity_perl_compiler
	autocmd!
	autocmd BufEnter * :let g:affinity_absolute_path = expand("%:p")
	autocmd BufEnter * :let g:affinity_relative_path = substitute(g:affinity_absolute_path, g:affinity_working_directory,"","")
	nnoremap <leader>cp :<c-u>execute ":!ssh vbox -t \"perl -I /data/affinitylive/modules -c /data/affinitylive/\"" . g:affinity_relative_path<cr>
augroup END

