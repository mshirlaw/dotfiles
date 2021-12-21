if (has("termguicolors"))
    set termguicolors
endif

augroup syntax_highlight
	autocmd!
	autocmd BufEnter * :syntax sync fromstart
augroup END

" handled by treesitter

" if !exists("g:syntax_on")
"     syntax enable
" endif

if !exists('g:loaded_color')
  let g:loaded_color = 1
  colorscheme night-owl
endif