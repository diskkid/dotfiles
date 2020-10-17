set nocompatible
let mapleader = " "

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
call plug#begin(stdpath('data') . '/plugged')
Plug 'vim-scripts/L9'
Plug 'Shougo/denite.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'chriskempson/base16-vim'

Plug 'mattn/emmet-vim'

Plug 'cespare/vim-toml'

Plug 'mattn/vim-goimports'
call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source $XDG_CONFIG_HOME/nvim/denite.vim
source $XDG_CONFIG_HOME/nvim/coc.vim
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
colorscheme base16-default-dark

" Indent
set autoindent
set smartindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

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
set list
set listchars=tab:»-

let g:netrw_banner = 0

" Autocmd
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
autocmd QuickFixCmdPost *grep* cwindow

" Key mapping
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <Leader>e :edit %%

nmap <silent> <C-n> gt<CR>
nmap <silent> <C-p> gT<CR>
nmap <silent> <M-n> :tabm +1<CR>
nmap <silent> <M-p> :tabm -1<CR>
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
