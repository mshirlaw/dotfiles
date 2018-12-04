" mshirlaw
" 3 December 2018

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

filetype plugin indent on

" custom settings
syntax enable

" colours
" colorscheme afterglow
colorscheme skyhawk

set number
set autoindent
set ts=4 sw=4
set noexpandtab
set mouse=a
set binary
set noeol
set incsearch
set ignorecase
set cursorline
set path=$PWD/**

" set .tt file type to html
au BufNewFile,BufRead *.tt set filetype=html

" syntax highlighting from the start always
autocmd BufEnter * :syntax sync fromstart

" allow autocomplete when searching files in directory
set wildmenu

" set custom leader key
let mapleader = ","

" visual mode key mappings

" git blame (selected lines)
vnoremap <leader>b :<C-U>execute ":!git blame -L " . line("'<") . "," . line("'>") . " " . "%"<CR>

" normal mode key mappings

" git blame (single line)
nnoremap <leader>b :<C-U>execute ":!git blame -L " . line(".") . "," . line(".") . " " . "%"<CR>
"ctrl-p
nnoremap <leader>p :CtrlP<CR>
" find
nnoremap <leader>f :Ack! 
" perltidy whole file
nnoremap <leader>t :%!perltidy<CR>
" perlcritic
nnoremap <leader>c <ESC>:compiler perlcritic<bar>:make<CR><bar>:cope<CR>

" ctrl-p
let g:ctrlp_max_files=0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'ack %s -l --nocolor -g ""']


