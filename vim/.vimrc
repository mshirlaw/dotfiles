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
Plugin 'mshirlaw/jira-prepend'
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
set tm=500
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
augroup tt_as_html
	autocmd!
	autocmd BufNewFile,BufRead *.tt set filetype=html
augroup END

" syntax highlighting from the start always
augroup syntax_highlight
	autocmd!
	autocmd BufEnter * :syntax sync fromstart
augroup END

" set custom leader key
let mapleader = ","

" visual mode key mappings, git blame (selected lines) format as json (selected lines), perltidy selection
vnoremap <leader>td :!perltidy<cr>
vnoremap <leader>bl :<c-u>execute ":!clear && git blame -L " . line("'<") . "," . line("'>") . " " . "%"<cr>
vnoremap <leader>fj :!python -m json.tool<cr>

" normal mode key mappings, git blame (single line), ctrl-p, find, perltidy whole file, perlcritic, format as json (whole file)
nnoremap <leader>f :Ack! 
nnoremap <leader>p :CtrlP<cr>
nnoremap <leader>td :%!perltidy<cr>
nnoremap <leader>bl :<c-u>execute ":!clear && git blame -L " . line(".") . "," . line(".") . " " . "%"<cr>
nnoremap <leader>cr <esc>:compiler perlcritic<bar>:make<cr><bar>:cope<cr>
nnoremap <leader>fj :%!python -m json.tool<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

nnoremap <left> <nop>
nnoremap <down> <nop>
nnoremap <up> <nop>
nnoremap <right> <nop>

" plugin globals
let g:ctrlp_max_files=0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif
let g:jira_prepend_ticket_pattern="AFFINITY"
let g:jira_prepend_custom_message="#time "

" experimental for moving into a plugin

let g:affinity_working_directory="/Users/mshirlaw/Documents/accelo/affinitylive/"

augroup affinity_perl_compiler
	autocmd!
	autocmd BufEnter * :let g:affinity_absolute_path = expand("%:p")
	autocmd BufEnter * :let g:affinity_relative_path = substitute(g:affinity_absolute_path, g:affinity_working_directory,"","")
	nnoremap <leader>co :<c-u>execute ":!clear && echo \"Compiling...\" && ssh vbox -t \"perl -I /data/affinitylive/modules -c /data/affinitylive/\"" . g:affinity_relative_path<cr>
augroup END

function! s:ConvertSearch(search)
	let g:escaped_string = substitute(a:search, '\$', '\\\\\\$', 'g')
	let g:escaped_string_two = substitute(g:escaped_string, '#', '\\\\\\#', 'g')
	let g:escaped_string_three = substitute(g:escaped_string_two, '%', '\\\\\\%', 'g')
	let g:escaped_string_four = substitute(g:escaped_string_three, '(', '\\\\\\(', 'g')
	let g:escaped_string_five = substitute(g:escaped_string_four, ')', '\\\\\\)', 'g')
	let g:escaped_string_six = substitute(g:escaped_string_five, '{', '\\\\\\{', 'g')
	let g:escaped_string_seven = substitute(g:escaped_string_six, '}', '\\\\\\}', 'g')
	let g:escaped_string_eight = escape(g:escaped_string_seven, "'")
	execute "Ack! " . escape(g:escaped_string_eight, ' /=,>@')
	"echom escape(g:escaped_string_eight, ' /=')
	return 1
endfunction

command! -nargs=1 Search call s:ConvertSearch(<q-args>)
nnoremap <leader>s :Search! 