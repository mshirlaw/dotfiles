" 10 July 2021
" init.vim
" Matt Shirlaw

" plugins
source $HOME/.config/nvim/vim-plug/plugins.vim

" syntax highlighting and color scheme
source $HOME/.config/nvim/syntax/config.vim

" general settings
source $HOME/.config/nvim/settings/config.vim

" plugin specific lua settings 
luafile $HOME/.config/nvim/nvim-compe/config.lua
luafile $HOME/.config/nvim/nvim-telescope/config.lua
luafile $HOME/.config/nvim/nvim-lspconfig/config.lua
luafile $HOME/.config/nvim/lspsaga/config.lua

" plugin specific vim settings
source $HOME/.config/nvim/fzf/config.vim
source $HOME/.config/nvim/lightline/config.vim
source $HOME/.config/nvim/nerdtree/config.vim
source $HOME/.config/nvim/vim-prettier/config.vim

" key bindings
source $HOME/.config/nvim/mappings/config.vim