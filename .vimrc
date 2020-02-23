" mshirlaw
" 12 February 2020

set nocompatible
filetype off

cd .

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/after/

call vundle#begin()
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'SirVer/ultisnips'
Plugin 'VundleVim/Vundle.vim'
Plugin 'dyng/ctrlsf.vim'
Plugin 'ianks/vim-tsx'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'lifepillar/vim-mucomplete'
Plugin 'mshirlaw/jira-prepend'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'prettier/vim-prettier'
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdtree'
Plugin 'tomasiser/vim-code-dark'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
call vundle#end()

filetype plugin on
syntax enable

" auto-completion settings
set omnifunc=syntaxcomplete#Complete
set completeopt+=menuone,noinsert
set shortmess+=c
set belloff+=ctrlg

if isdirectory($HOME . '/.vim/bundle/vim-code-dark')	
	colorscheme codedark	
else	
	colorscheme afterglow	
endif

hi Search cterm=bold gui=bold
hi link xmlEndTag xmlTag

set number
set relativenumber
set autoindent
set nosmartindent
set nocindent
set ts=4 sw=4 expandtab

if isdirectory($HOME . '/.tmp')
	set directory=$HOME/.tmp
endif

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

" visual mode key mappings, format as json, highlight last selection after indent
vnoremap <leader>js :!python -m json.tool<cr>
vnoremap < <gv
vnoremap > >gv

" normal mode key mappings
nnoremap <leader>ff :FZF<cr>
nnoremap <leader>bb :Buffers<cr>
nnoremap <leader>ag :Ag<cr>
nnoremap <leader>js :%!python -m json.tool<cr>
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>sn :e $HOME/.vim/UltiSnips<cr>
nnoremap <leader>aa ggVG
nnoremap <leader>ra *G :%s///g<left><left>
nnoremap <leader>rc *G :%s///gc<left><left><left>

" ALE mappings
nnoremap <c-a>f :ALEFix<cr>
nnoremap <c-a>d :ALEGoToDefinition<cr>
nnoremap <c-a>r :ALEFindReferences<cr>
nnoremap <c-a>s :ALESymbolSearch<cr>

" window navigation mappings
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" alternative buffer switching
nnoremap <space><right> :bn<cr>
nnoremap <space><left> :bp<cr>
nnoremap <space><down> :bd<cr>

" nerd tree mappings
map <c-n>t :NERDTreeToggle<cr>
nnoremap <c-n>f :NERDTreeFind<cr>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" CtrlSF maps
nmap <c-f>f <Plug>CtrlSFPrompt
nmap <c-f>n <Plug>CtrlSFCwordPath
nmap <c-f>p <Plug>CtrlSFPwordPath
vmap <c-f>f <Plug>CtrlSFVwordPath
vmap <c-f>F <Plug>CtrlSFVwordExec

" nerd tree plugin globals
let NERDTreeShowLineNumbers=1
let g:NERDTreeNodeDelimiter="\u00a0"

" jira prepend plugin globals
let g:jira_prepend_ticket_pattern="CAC"
let g:jira_prepend_custom_message=""

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
if isdirectory($HOME . '/.vim/bundle/vim-code-dark')
	let g:airline_theme='codedark'	
else	
	let g:airline_themne='afterglow'	
endif

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_symbols.dirty='⚡'

" ale linter plugin globals
let g:ale_sign_error='>>'
let g:ale_sign_warning='>>'
let g:ale_linters_explicit=1
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

let g:ale_fixers = {
\	'javascript': ['prettier'],
\	'css': ['prettier']
\}

let g:UltiSnipsExpandTrigger="<tab>"    
let g:UltiSnipsJumpForwardTrigger="<tab>"      
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let g:ctrlsf_position="right"

let g:mucomplete#enable_auto_at_startup=1
let g:mucomplete#no_mappings =1
