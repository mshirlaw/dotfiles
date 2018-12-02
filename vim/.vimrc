" mshirlaw
" 2 December 2018

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

" some simple snippets
au filetype perl :iabbrev dmp use Data::Dumper;<CR>warn Dumper;<LEFT>
au filetype perl :iabbrev tcf try {<CR>}<CR>catch {<CR>}<CR>finally {<CR>};
au filetype javascript :iabbrev log console.log('debug');

" git blame via F4
vnoremap <F4> :<C-U>execute ":!git blame -L " . line("'<") . "," . line("'>") . " " . "%"<CR>

" ctrl-p
let g:ctrlp_max_files=0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'ack %s -l --nocolor -g ""']

