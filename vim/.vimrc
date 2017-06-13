" author: mshirlaw
" date: April 2017

" allow syntax highlighting and set the color scheme to wombat256mod
syntax on
colorscheme wombat256mod

" display line numbers
set number

" set the defail path to search recursively in the cwd to allow the :find command
set path=$PWD/**

" show tabs, end of line and space characters
set list
set listchars=tab:»\ ,eol:¬,space:·

" set the tab width as 4 spaces
set ts=4 sw=4

" treat files of type .tt as html
au BufNewFile,BufRead *.tt set filetype=html

" auto indent on hitting return 
set autoindent

" autocomplete during :find operations
set wildmenu
