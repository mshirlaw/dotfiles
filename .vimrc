" mshirlaw
" 8 September 2019

set nocompatible
filetype off

cd .

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/after/

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasiser/vim-code-dark'
Plugin 'scrooloose/nerdtree'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'SirVer/ultisnips'
Plugin 'mshirlaw/jira-prepend'
Plugin 'mshirlaw/remote-compile'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-fugitive'
Plugin 'w0rp/ale'
call vundle#end()

filetype plugin on

" custom settings

syntax enable

if isdirectory($HOME . '/.vim/bundle/vim-code-dark')
	colorscheme codedark
endif

hi Search cterm=bold gui=bold
hi link xmlEndTag xmlTag

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

" cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" set custom leader key
let mapleader = ","

" visual mode key mappings, perltidy selection, format as json, highlight last selection after indent
vnoremap <leader>td :!perltidy<cr>
vnoremap <leader>js :!python -m json.tool<cr>
vnoremap < <gv
vnoremap > >gv

" normal mode key mappings
nnoremap <leader>ff :Files<cr>
nnoremap <leader>bb :Buffers<cr>
nnoremap <leader>ag :Ag<cr>
nnoremap <leader>td :%!perltidy<cr>
nnoremap <leader>cr <esc>:compiler perlcritic<bar>:make<cr><bar>:cope<cr>
nnoremap <leader>js :%!python -m json.tool<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ll :lnext<cr>
nnoremap <leader>lp :lprev<cr>

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" alternative buffer switching
nnoremap <space><right> :bn<cr>
nnoremap <space><left> :bp<cr>
nnoremap <space><down> :bd<cr>

nnoremap <c-]> :execute "tjump " . expand("<cword>")<cr>
map <c-n> :NERDTreeToggle<cr>

" nerd tree plugin globals
let NERDTreeShowLineNumbers=1
let g:NERDTreeNodeDelimiter="\u00a0"

" jira prepend plugin globals
let g:jira_prepend_ticket_pattern="CAC"
let g:jira_prepend_custom_message=""

" remote compile plugin globals
let g:remote_compile_project_dir="/Users/mshirlaw/Documents/accelo/affinitylive/"

" FZF plugin globals
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

" airline plugin globals
let g:airline_theme='codedark'

" ale linter plugin globals
let g:ale_sign_error='>>'
let g:ale_sign_warning='>>'
let g:ale_linters_explicit=1
let g:ale_linters = {
\   'javascript': ['eslint'],
\}