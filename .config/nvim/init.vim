set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')
    call dein#add('~/.local/share/dein')

    call dein#load_toml('~/.config/nvim/dein/sync.toml')
    call dein#load_toml('~/.config/nvim/dein/elm.toml', {'on_ft': 'elm'})
  call dein#end()

  if dein#check_install()
    call dein#install()
  endif

  call dein#save_state()
endif

filetype plugin indent on
syntax enable
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Indent
set autoindent
set smartindent
set expandtab
set shiftwidth=2
set softtabstop=2

" Common
set termguicolors
set number
set ruler
set backspace=indent,eol,start

" Rust
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

