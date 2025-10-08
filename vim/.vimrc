"-------------------------------------------------------
" GENERAL SETTINGS
"-------------------------------------------------------

" Disable vi compatibility
set nocompatible

colorscheme nord

" <BckSpc> can delete everything in insert mode
set backspace=eol,indent,start

" Show matching parentheses
set showmatch

" Incremental search
set incsearch

" No case sensitive search, unless explicitly
" searching for uppercase letters
set ignorecase
set smartcase

" Show context around cursor
set scrolloff=2
set sidescrolloff=2

" <Tab> completion on command line
set wildmode=list:longest,full

" Set command history to 50 lines
set history=50

" Hightlight the line the cursor is on
set cursorline

" Show cursor position
set ruler

" Show line number and relative line numbers
set number
set relativenumber

" Folding
set foldenable
set foldmethod=indent
set foldlevel=1
set foldlevelstart=99
set foldcolumn=1

" Indentation etc.
set expandtab
set tabstop=2
set listchars=trail:␣,tab:»\ 
set list
set smartindent
set autoindent

" Enable terminal mouse support
set mouse=a

cabbrev Wq wq

" Netrw
let g:netrw_keepdir = 0
let g:netrw_winsize = 30
let g:netrw_banner = 0

hi! link netrwMarkFile Search
nnoremap \ :Lexplore<cr>

"-------------------------------------------------------
" USER INTERFACE
"-------------------------------------------------------

filetype plugin indent on
syntax on
set modeline

" Statusbar
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%-10.(%l,%c%V%)\ %<%P        " offset
