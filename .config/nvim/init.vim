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

" Themes
Plug 'chriskempson/base16-vim'

Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'mattn/emmet-vim'

Plug 'cespare/vim-toml'

Plug 'mattn/vim-goimports'

Plug 'kovisoft/paredit'
Plug 'vlime/vlime', {'rtp': 'vim/'}
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
set updatetime=100

let g:netrw_banner = 0

" Autocmd
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
autocmd QuickFixCmdPost *grep* cwindow

" Key mapping
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <Leader>e :tabe %%

nnoremap <silent> <S-h> ^
nnoremap <silent> <S-l> $

nnoremap <silent> <C-n> gt<CR>
nnoremap <silent> <C-p> gT<CR>
nnoremap <silent> <M-n> :tabm +1<CR>
nnoremap <silent> <M-p> :tabm -1<CR>
nnoremap <silent> <C-c> :bd %<CR>

nnoremap <silent> <Leader>n :tabm +1<CR>
nnoremap <silent> <Leader>p :tabm -1<CR>

nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

nnoremap <Leader>r :source $XDG_CONFIG_HOME/nvim/init.vim<CR>

nnoremap [fugitive] <Nop>
nmap <Leader>g [fugitive]
nnoremap <silent> [fugitive]g :Git<CR>
nnoremap <silent> [fugitive]d :Git diff<CR>

" Terminal
tnoremap <ESC> <C-\><C-n>

" C
autocmd BufRead,BufNewFile *.h,*.c set filetype=c
