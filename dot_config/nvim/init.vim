"                        _
"  _ __   ___  _____   _(_)_ __ ___
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \
" | | | |  __/ (_) \ V /| | | | | | |
" |_| |_|\___|\___/ \_/ |_|_| |_| |_|


" no vi compat mode
set nocompatible

" enable filetype
filetype plugin on
filetype indent on

set guifont=Noto\ Sans\ Mono:h11

" color
packadd! dracula
syntax on
colorscheme dracula
set background=dark

" lines
set number
set cursorline
highlight CursorLine cterm=NONE ctermbg=237 ctermfg=NONE guibg=black
highlight CursorLineNR cterm=NONE ctermbg=237 guibg=black
set linespace=2

" tabs
set expandtab
set tabstop=2
set shiftwidth=2

" buffers
set hidden
set laststatus=2
set autoread
set so=7
set ruler

" search settings
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set mat=2

" wildmenu
set wildmenu
set wildignore=*.o,*.swp,*.pyc,.git\*

" enable per-project vimrc
set exrc
set secure

" disable swap files
set nobackup
set noswapfile
set nowritebackup

" spelling
set spelllang=en
set spellsuggest=best,10

" keys
imap jj <Esc>

" enable mouse
set mouse=a

" whitespace
set listchars=eol:$,tab:>.,trail:~,space:.
nnoremap <Leader>w :set list!<CR>

" etc
set magic
set encoding=utf8
set backspace=2

" line moving
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" buffer directory expansion
cabbr <expr> %% expand('%:p:h')
