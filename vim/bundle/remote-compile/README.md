Remote Compile
==============

Remote compile lets you edit a perl script on your local machine and compile it on
a remote host. This is useful if your workflow involves editing code on your local
development machine which is executed on a remote server or virtual machine.

Usage
-----

In your `.vimrc` you should specify `g:remote_compile_project_dir`. Remote compile
will use this file path to extract the relative path of the file you wish to compile and 
`ssh` to the remote host and find the same file in the shared folder and compile it.

In your `.vimrc` you can specifiy the full path to your local project directory and create
a mapping for the remote compile command as follows:

	let g:remote_compile_project_dir="/path/to/project"
	
	nnoremap <leader>co :RemoteCompile<cr>

Installation
------------

If you don't have a preferred installation method, I recommend 
using [Vundle](https://github.com/VundleVim/Vundle.vim). Assuming you 
have Vundle installed and configured, the following steps will install the plugin:

Add the following line to your `~/.vimrc` and then run `:PluginInstall` from within Vim:

``` vim
call vundle#begin()
" ...
Plugin 'mshirlaw/remote-compile'
" ...
call vundle#end()
```
