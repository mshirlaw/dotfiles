augroup nerd_tree
    autocmd FileType nerdtree setlocal relativenumber
augroup END

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let NERDTreeShowLineNumbers=1
let g:NERDTreeNodeDelimiter="\u00a0"
