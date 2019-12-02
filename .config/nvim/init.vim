set nocompatible
let mapleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Dein
set runtimepath+=~/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/dein')
  call dein#begin('~/.local/share/dein')
    call dein#add('~/.local/share/dein')

    call dein#load_toml('~/.config/nvim/dein/sync.toml')
    call dein#load_toml('~/.config/nvim/dein/elixir.toml', {'on_ft': 'elixir'})
    call dein#load_toml('~/.config/nvim/dein/elm.toml',    {'on_ft': 'elm'})
    call dein#load_toml('~/.config/nvim/dein/fish.toml',   {'on_ft': 'fish'})
    call dein#load_toml('~/.config/nvim/dein/js.toml',     {'on_ft': 'javascript'})
    call dein#load_toml('~/.config/nvim/dein/ruby.toml',   {'on_ft': 'ruby'})
    call dein#load_toml('~/.config/nvim/dein/rust.toml',   {'on_ft': 'rust'})
    call dein#load_toml('~/.config/nvim/dein/slim.toml',   {'on_ft': 'slim'})
    call dein#load_toml('~/.config/nvim/dein/toml.toml',   {'on_ft': 'toml'})
    call dein#load_toml('~/.config/nvim/dein/ts.toml',     {'on_ft': 'typescript'})
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
set ts=2

" Common
set termguicolors
set number
set ruler
set backspace=indent,eol,start
set splitbelow splitright
set nobackup
set nowritebackup
set autoread
set scrolloff=5
set wildmenu
set wildmode=longest,full
set hidden
set cursorline
set lazyredraw

let g:netrw_banner = 0

" Autocmd
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
autocmd QuickFixCmdPost *grep* cwindow

" MoveToNewTab
nnoremap <silent> tm :<C-u>call <SID>MoveToNewTab()<CR>
function! s:MoveToNewTab()
  tab split
  tabprevious

  if winnr('$') > 1
    close
  elseif bufnr('$') > 1
    buffer #
  endif

  tabnext
endfunction

" Key mapping
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <Leader>e :edit %%

nmap <silent> <C-n> :bnext<CR>
nmap <silent> <C-p> :bprev<CR>
nmap <silent> <C-c> :bd %<CR>

nmap <silent> <Leader>n :tabm +1<CR>
nmap <silent> <Leader>p :tabm -1<CR>

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nmap <Leader>r :source $XDG_CONFIG_HOME/nvim/init.vim<CR>

" Terminal
tnoremap <ESC> <C-\><C-n>

" C
autocmd BufRead,BufNewFile *.h,*.c set filetype=c
