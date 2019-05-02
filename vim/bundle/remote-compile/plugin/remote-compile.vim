" Package: Remote Compile 
" Maintainer: Matt Shirlaw
" Last Change: 23 December 2018

if exists("g:remote_compile_loaded")
	finish
endif

let g:remote_compile_loaded = 1

function! RemoteCompile()
	let absolute_path = expand("%:p")
	let relative_path = substitute(absolute_path, g:remote_compile_project_dir,"","")
	:execute ":!clear && echo \"Compiling...\" && ssh vbox -t \"perl -I /data/affinitylive/modules -c /data/affinitylive/" . relative_path . "\""
endfunction

command! -bar -nargs=0 RemoteCompile call RemoteCompile()
