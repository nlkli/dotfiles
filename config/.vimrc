syntax on
filetype plugin indent on
set number
set relativenumber
set termguicolors
set background=dark
colorscheme lunaperche
set hidden
set noswapfile
set encoding=utf-8
set autoread
set undodir=~/.vim/undodir
set undofile
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent
set ignorecase
set smartcase
set incsearch
set nohlsearch
set wrap
set linebreak
set scrolloff=6
set sidescrolloff=4
set mouse=a
set wildmenu
set updatetime=300
set timeoutlen=500
set belloff=all
let g:netrw_banner = 0
let g:netrw_liststyle = 1

let mapleader = " "
nnoremap <leader>y "+y
xnoremap <leader>y "+y
nnoremap <leader>p "+p
xnoremap <leader>p "+p
nnoremap <leader>P "+P
xnoremap <leader>P "+P
nnoremap <leader>q :x<CR>
nnoremap <leader>w :update<CR>
nnoremap <leader>e :edit %:h<CR>
nnoremap <leader>E :edit .<CR>
nnoremap <leader>r :edit #<CR>
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
xnoremap <leader>s y:%s/<C-r>"//g<Left><Left>
nnoremap <leader>u :source ~/.vimrc<CR>
nnoremap <leader>o :copen<CR>
nnoremap <leader>c :cclose<CR>
nnoremap <leader>t :tabnew | terminal<CR>
nnoremap n nzzzv
nnoremap N Nzzzv
