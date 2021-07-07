if (has("termguicolors"))
    set termguicolors
endif

augroup syntax_highlight
	autocmd!
	autocmd BufEnter * :syntax sync fromstart
augroup END

syntax enable
colorscheme night-owl