lua require("mshirlaw")

let mapleader = ","

" visual mode key mappings
vnoremap <leader>js :!python -m json.tool<cr>
vnoremap < <gv
vnoremap > >gv

" copy file paths
nnoremap <leader>yp :let @*=expand("%:p")<cr>
nnoremap <leader>yd :let @*=@%<cr>

" format json
nnoremap <leader>js :%!python -m json.tool<cr>

" working with .vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>fv :lua require("mshirlaw.telescope").search_dotfiles()<cr>
nnoremap <leader>fn :lua require("mshirlaw.telescope").search_notes()<cr>

" highlight all
nnoremap <leader>ha ggVG

" find and replace
nnoremap <leader>ra *G :%s///g<left><left>
nnoremap <leader>rc *G :%s///gc<left><left><left>

" window switching
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" alternative buffer switching
nnoremap <TAB> :bn<cr>
nnoremap <S-TAB> :bp<cr>
nnoremap <S-DOWN> :bw!<cr>

" Find files using telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" nvim tree
map <c-n>t ::NvimTreeToggle<cr>
nnoremap <c-n>f :NvimTreeFindFile<cr>

"git fugitive
nmap <leader>gs :G<CR>
nmap <leader>gf :Gdiffsplit<cr>
nmap <leader>gb :Git blame<cr>

