" 7 July 2021
" init.vim
" Matt Shirlaw

" plugins
source $HOME/.config/nvim/vim-plug/plugins.vim

" general settings
source $HOME/.config/nvim/settings/config.vim

" plugin specific settings 
luafile $HOME/.config/nvim/nvim-compe/config.lua
source $HOME/.config/nvim/fzf/config.vim
source $HOME/.config/nvim/lightline/config.vim
source $HOME/.config/nvim/nerdtree/config.vim
source $HOME/.config/nvim/nvim-lspconfig/config.vim
source $HOME/.config/nvim/vim-prettier/config.vim

" syntax highlighting and color scheme
source $HOME/.config/nvim/syntax/config.vim

" key bindings
source $HOME/.config/nvim/mappings/config.vim

