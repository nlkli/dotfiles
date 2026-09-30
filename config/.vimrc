set termguicolors
colorscheme default

set number
set relativenumber
set wrap
set scrolloff=4
set sidescrolloff=4
set showmatch
set matchtime=2
set guicursor=i:block

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set autoindent

set ignorecase
set smartcase
set nohlsearch
set incsearch

set hidden
set backspace=indent,eol,start
set noerrorbells
set belloff=all
set mouse=a
set encoding=UTF-8
set modifiable

set nobackup
set nowritebackup
set noswapfile
set undofile
set undolevels=10000
set undodir=~/.vim/undodir.vim

if !isdirectory($HOME . "/.vim/undodir.vim")
    call mkdir($HOME . "/.vim/undodir.vim", "p")
endif

set updatetime=300
set timeoutlen=500
set ttimeoutlen=0
set autoread
set autowrite
set synmaxcol=300
set redrawtime=10000
set maxmempattern=20000

set foldlevel=99

set formatoptions=jcroqlnt
set grepformat=%f:%l:%c:%m
set wildmenu
set wildmode=longest:full,full
set linebreak

syntax on
filetype plugin indent on

let g:netrw_banner=0
let g:netrw_liststyle=1

set langmap=ёй,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ],фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э',яz,чx,сc,мv,иb,тn,ьm,ё`,ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ},ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\\:,Э\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Ё~
set langremap

let mapleader=" "

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
nnoremap <leader>b :bnext<CR>
nnoremap <leader>B :bnext<CR>
nnoremap <leader>o :copen<CR>
nnoremap <leader>l :lopen<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>N :cprev<CR>
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lN :lprev<CR>
nnoremap <leader>c :cclose \| lclose<CR>
nnoremap <leader>t :tabnew \| edit .<CR>
nnoremap <leader>R :source ~/.vim/.vimrc<CR>

nnoremap <leader>н "+y
xnoremap <leader>н "+y
nnoremap <leader>з "+p
xnoremap <leader>з "+p
nnoremap <leader>З "+P
xnoremap <leader>З "+P
nnoremap <leader>й :x<CR>
nnoremap <leader>ц :update<CR>
nnoremap <leader>у :edit %:h<CR>
nnoremap <leader>У :edit .<CR>
nnoremap <leader>к :edit #<CR>
nnoremap <leader>ы :%s/\<<C-r><C-w>\>//g<Left><Left>
xnoremap <leader>ы y:%s/<C-r>"//g<Left><Left>
nnoremap <leader>и :bnext<CR>
nnoremap <leader>И :bnext<CR>
nnoremap <leader>щ :copen<CR>
nnoremap <leader>д :lopen<CR>
nnoremap <leader>т :cnext<CR>
nnoremap <leader>Т :cprev<CR>
nnoremap <leader>дт :lnext<CR>
nnoremap <leader>дТ :lprev<CR>
nnoremap <leader>с :cclose \| lclose<CR>
nnoremap <leader>е :tabnew \| edit .<CR>
nnoremap <leader>К :source ~/.vim/.vimrc<CR>

if executable("rg")
    set grepprg=rg\ --vimgrep
    command! -nargs=+ -complete=file Rg silent grep! <args> | copen
    nnoremap <leader>g :Rg 
endif

if executable("fd")
    command! -nargs=+ -complete=file Fd
        \ let $FD_ARGS = <q-args> |
        \ set efm=%f |
        \ lexpr system("fd " . $FD_ARGS) |
        \ lopen
    nnoremap <leader>f :Fd 
endif

" recol:start
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "Golden Retriever Red"
set background=light

hi Normal        guifg=#6b3d2a guibg=#fff0e3
hi NormalNC      guifg=#6b3d2a guibg=#fff0e3
hi Terminal      guifg=#6b3d2a guibg=#fff0e3
hi ColorColumn   guibg=#f0e2d5
hi Conceal       guifg=#c4b8ae
hi Cursor        guifg=#6b3d2a guibg=#c97b2e
hi lCursor       guifg=#6b3d2a guibg=#c97b2e
hi CursorIM      guifg=#6b3d2a guibg=#c97b2e
hi CursorColumn  guibg=#e0d3c8
hi CursorLine    guibg=#e0d3c8
hi Directory     guifg=#65b8e8
hi EndOfBuffer   guifg=#fff0e3
hi ErrorMsg      guifg=#d3542c
hi VertSplit     guifg=#fff0e3
hi WinSeparator  guifg=#fff0e3
hi Folded        guifg=#d67a54 guibg=#f0e2d5
hi FoldColumn    guifg=#d67a54
hi SignColumn    guifg=#d67a54
hi Substitute    guifg=#fff0e3 guibg=#d3542c
hi LineNr        guifg=#d67a54
hi CursorLineNr  guifg=#d9a441 gui=bold
hi MatchParen    guifg=#d9a441 gui=bold
hi ModeMsg       guifg=#d9a441 gui=bold
hi MoreMsg       guifg=#468bd6 gui=bold
hi Question      guifg=#468bd6 gui=bold
hi NonText       guifg=#c4b8ae
hi SpecialKey    guifg=#c4b8ae
hi Pmenu         guifg=#6b3d2a guibg=#e8d4c6
hi PmenuSel      guifg=#6b3d2a guibg=#f7dec7
hi PmenuSbar     guibg=#e8d4c6
hi PmenuThumb    guibg=#f7dec7
hi QuickFixLine  guibg=#e0d3c8
hi Search        guifg=#6b3d2a guibg=#f7dec7
hi IncSearch     guifg=#fff0e3 guibg=#7a9b45
hi CurSearch     guifg=#fff0e3 guibg=#7a9b45
hi StatusLine       guifg=#a65e41 guibg=#fff0e3
hi StatusLineNC     guifg=#d67a54 guibg=#fff0e3
hi StatusLineTerm   guifg=#a65e41 guibg=#fff0e3
hi StatusLineTermNC guifg=#d67a54 guibg=#fff0e3
hi TabLine       guifg=#a65e41 guibg=#f0e2d5
hi TabLineFill   guibg=#fff0e3
hi TabLineSel    guifg=#fff0e3 guibg=#d67a54
hi Title         guifg=#65b8e8 gui=bold
hi Visual        guibg=#e8d4c6
hi VisualNOS     guibg=#e8d4c6
hi WarningMsg    guifg=#d9a441
hi Whitespace    guifg=#e0d3c8
hi WildMenu      guifg=#6b3d2a guibg=#e8d4c6
hi WinBar        guifg=#d67a54 guibg=#fff0e3 gui=bold
hi WinBarNC      guifg=#d67a54 guibg=#fff0e3 gui=bold
hi Menu          guifg=#6b3d2a guibg=#fff0e3
hi Scrollbar     guibg=#fff0e3
hi Tooltip       guifg=#6b3d2a guibg=#fff0e3

hi SpellBad   gui=undercurl guisp=#d3542c
hi SpellCap   gui=undercurl guisp=#d9a441
hi SpellLocal gui=undercurl guisp=#468bd6
hi SpellRare  gui=undercurl guisp=#468bd6

hi DiffAdd    guibg=#bdc694
hi DiffChange guibg=#a3bedd
hi DiffDelete guibg=#e9a288
hi DiffText   guibg=#dfb5d8

hi Comment        guifg=#a68574
hi Constant       guifg=#de904e
hi String         guifg=#7a9b45
hi Character      guifg=#7a9b45
hi Number         guifg=#d67c37
hi Boolean        guifg=#d67c37
hi Float          guifg=#d67c37
hi Identifier     guifg=#4db7a0
hi Function       guifg=#65b8e8
hi Statement      guifg=#b05cc7
hi Conditional    guifg=#c889e0
hi Repeat         guifg=#c889e0
hi Label          guifg=#c889e0
hi Operator       guifg=#a65e41
hi Keyword        guifg=#b05cc7
hi Exception      guifg=#b05cc7
hi PreProc        guifg=#ed8d8d
hi Include        guifg=#ed8d8d
hi Define         guifg=#ed8d8d
hi Macro          guifg=#ed8d8d
hi PreCondit      guifg=#ed8d8d
hi Type           guifg=#d9a441
hi StorageClass   guifg=#d9a441
hi Structure      guifg=#d9a441
hi Typedef        guifg=#d9a441
hi Special        guifg=#65b8e8
hi SpecialChar    guifg=#65b8e8
hi Tag            guifg=#65b8e8
hi Delimiter      guifg=#65b8e8
hi SpecialComment guifg=#65b8e8
hi Debug          guifg=#65b8e8
hi Underlined     guifg=#65b8e8 gui=underline
hi Ignore         guifg=#f0e2d5
hi Error          guifg=#d3542c
hi Todo           guifg=#fff0e3 guibg=#468bd6

hi qfLineNr      guifg=#d67a54
hi qfFileName    guifg=#65b8e8

hi diffAdded     guifg=#7a9b45
hi diffRemoved   guifg=#d3542c
hi diffChanged   guifg=#468bd6
hi diffOldFile   guifg=#d9a441
hi diffNewFile   guifg=#7a9b45
hi diffFile      guifg=#468bd6
hi diffLine      guifg=#de904e
hi diffIndexLine guifg=#ed8d8d
" recol:end
