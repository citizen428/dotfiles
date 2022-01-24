"-------------------------------------------------------
" GENERAL SETTINGS
"-------------------------------------------------------

" <BckSpc> can delete everything in insert mode
set backspace=eol,indent,start

set showcmd

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

" Show cursor position
set ruler

" Show line numbers
set number

" Folding
set foldenable
set foldmethod=indent
set foldlevel=1
set foldcolumn=1

" Indent of 2
set shiftwidth=2
set softtabstop=2
set smartindent
set autoindent

set mouse=a
 
" Netrw
let g:netrw_keepdir = 0
let g:netrw_winsize = 30
let g:netrw_banner = 0

hi! link netrwMarkFile Search
nnoremap \ :Lexplore<cr>

"-------------------------------------------------------
" USER INTERFACE
"-------------------------------------------------------

colorscheme desert
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
set statusline+=0x%-8B\                      " current char
set statusline+=%-10.(%l,%c%V%)\ %<%P        " offset
