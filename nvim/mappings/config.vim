let mapleader = ","

" visual mode key mappings
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
nnoremap <leader>ha ggVG
nnoremap <leader>ra *G :%s///g<left><left>
nnoremap <leader>rc *G :%s///gc<left><left><left>

" window switching
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" alternative buffer switching
nnoremap <space><right> :bn<cr>
nnoremap <space><left> :bp<cr>
nnoremap <space><down> :bw!<cr>
