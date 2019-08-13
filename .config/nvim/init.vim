set nocompatible
let mapleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')
    call dein#add('~/.local/share/dein')

    call dein#load_toml('~/.config/nvim/dein/sync.toml')
    call dein#load_toml('~/.config/nvim/dein/c.toml', {'on_ft': 'c'})
    call dein#load_toml('~/.config/nvim/dein/elm.toml', {'on_ft': 'elm'})
    call dein#load_toml('~/.config/nvim/dein/slim.toml', {'on_ft': 'slim'})
    call dein#load_toml('~/.config/nvim/dein/js.toml', {'on_ft': 'javascript'})
    call dein#load_toml('~/.config/nvim/dein/ts.toml', {'on_ft': 'typescript'})
    call dein#load_toml('~/.config/nvim/dein/rust.toml', {'on_ft': 'rust'})
    call dein#load_toml('~/.config/nvim/dein/elixir.toml', {'on_ft': 'elixir'})
    call dein#load_toml('~/.config/nvim/dein/ruby.toml', {'on_ft': 'ruby'})
    call dein#load_toml('~/.config/nvim/dein/go.toml', {'on_ft': 'go'})
    call dein#load_toml('~/.config/nvim/dein/fish.toml', {'on_ft': 'fish'})
    call dein#load_toml('~/.config/nvim/dein/toml.toml', {'on_ft': 'toml'})
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
set splitbelow splitright
set nobackup
set autoread
set scrolloff=5
set wildmenu
set wildmode=longest,full

let g:netrw_banner = 0

" Autocmd
au VimEnter * call dein#call_hook('post_source')
au BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
" Remove all trailing whitespaces on save
au BufWritePre * %s/\s\+$//e

" Key mapping
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <Leader>e :edit %%
nmap <F8> :TagbarToggle<CR>

nmap <C-n> gt
nmap <C-p> gT

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Terminal
tnoremap <ESC> <C-\><C-n>

" C
au BufRead,BufNewFile *.h,*.c set filetype=c

" Rust
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

