"-------------------------------------------------------
" .vimrc from Michael Kohl <citizen428@gmail.com>
"
" Last update: Thu 2017-05-11 23:04
" 
"-------------------------------------------------------

"-------------------------------------------------------
" TERMINAL ENCODING
" ------------------------------------------------------

set termencoding=utf-8

"-------------------------------------------------------
" GENERAL SETTINGS
"-------------------------------------------------------

" No vi compatibility
set nocompatible

" Activate filetype detection, indentation etc.
filetype on
filetype indent on
filetype plugin on

" <BckSpc> can delete everything in insert mode
set backspace=eol,indent,start

" Show current mode
set showmode
set showcmd 

" Show matching parentheses
set showmatch

" Local macros start with ,
let maplocalleader = ','

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
set nu

" Folding
set foldenable
set foldmethod=indent
set foldlevel=1
set foldcolumn=1

" Activate linewrapping, but deactivate it for 
" comments (including Vim comments)
set nowrap
set comments+=b:\"
set formatoptions-=t
set textwidth=75

" Indent of 2
set shiftwidth=2
set softtabstop=2
set smartindent
set autoindent

set modeline

"-------------------------------------------------------
" USER INTERFACE
"------------------------------------------------------- 

colorscheme monokai

" Syntax highlighting
syntax on

" No menu und toolbar in GVim
set guioptions-=m
set guioptions-=T

"-------------------------------------------------------
" Keys
"-------------------------------------------------------

" <Space> = page down, "-" = page up
noremap <Space> <PageDown>
noremap - <Pageup>

" <Ctrl>+n/<Ctrl>+p jumps between files
nnoremap <C-n> :next<CR>
nnoremap <C-p> :prev<CR>

" Run current file as Ruby program
nnoremap <C-r> :!ruby %<CR>

" Correct one of my standard mistakes
cabbrev Wq wq

" sudo write
cabbrev w!! w !sudo tee >/dev/null "%"

"-------------------------------------------------------
" MacVim specific
"-------------------------------------------------------

" Set transparency for non active windows
au FocusLost * set transp=50
au FocusGained * set transp=0

"-------------------------------------------------------
" STATUSBAR
" ------------------------------------------------------

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

"-------------------------------------------------------
" AUTOCOMMANDS
"-------------------------------------------------------

" Update .*rc header
fun! <SID>UpdateRcHeader()
    let l:c=col(".")
    let l:l=line(".")
    1,4s-\(Last update:\).*-\="Last update: ".strftime("%a %Y\-%m\-%d %R")-
    call cursor(l:l, l:c)
endfun

" My autocommands
augroup citizen428
    autocmd!
    
     " Automatically update headers of vimrc and bashrc 
     autocmd BufWritePre *vimrc  :call <SID>UpdateRcHeader()
augroup END

"-------------------------------------------------------
" PLUGINS
"-------------------------------------------------------

" minibufexpl.vim
let g:miniBufExplModSelTarget = 1
let g:miniBufExplWinFixHeight = 1
