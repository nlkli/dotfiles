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
let g:colors_name = "Kanso Zen"
set background=dark

hi Normal        guifg=#c5c9c7 guibg=#090e13
hi NormalNC      guifg=#c5c9c7 guibg=#090e13
hi Terminal      guifg=#c5c9c7 guibg=#090e13
hi ColorColumn   guibg=#101922
hi Conceal       guifg=#24374b
hi Cursor        guifg=#090e13 guibg=#c5c9c7
hi lCursor       guifg=#090e13 guibg=#c5c9c7
hi CursorIM      guifg=#090e13 guibg=#c5c9c7
hi CursorColumn  guibg=#172532
hi CursorLine    guibg=#172532
hi Directory     guifg=#7fb4ca
hi EndOfBuffer   guifg=#090e13
hi ErrorMsg      guifg=#d17f79
hi VertSplit     guifg=#040608
hi WinSeparator  guifg=#040608
hi Folded        guifg=#5f605f guibg=#101922
hi FoldColumn    guifg=#5f605f
hi SignColumn    guifg=#5f605f
hi Substitute    guifg=#090e13 guibg=#d17f79
hi LineNr        guifg=#5f605f
hi CursorLineNr  guifg=#b3a27a gui=bold
hi MatchParen    guifg=#b3a27a gui=bold
hi ModeMsg       guifg=#b3a27a gui=bold
hi MoreMsg       guifg=#8ba4b0 gui=bold
hi Question      guifg=#8ba4b0 gui=bold
hi NonText       guifg=#24374b
hi SpecialKey    guifg=#24374b
hi Pmenu         guifg=#c5c9c7 guibg=#262b2f
hi PmenuSel      guifg=#c5c9c7 guibg=#262b2f
hi PmenuSbar     guibg=#262b2f
hi PmenuThumb    guibg=#262b2f
hi QuickFixLine  guibg=#172532
hi Search        guifg=#c5c9c7 guibg=#262b2f
hi IncSearch     guifg=#090e13 guibg=#8a9a7b
hi CurSearch     guifg=#090e13 guibg=#8a9a7b
hi StatusLine       guifg=#8e918f guibg=#040608
hi StatusLineNC     guifg=#5f605f guibg=#040608
hi StatusLineTerm   guifg=#8e918f guibg=#040608
hi StatusLineTermNC guifg=#5f605f guibg=#040608
hi TabLine       guifg=#8e918f guibg=#101922
hi TabLineFill   guibg=#040608
hi TabLineSel    guifg=#090e13 guibg=#5f605f
hi Title         guifg=#7fb4ca gui=bold
hi Visual        guibg=#262b2f
hi VisualNOS     guibg=#262b2f
hi WarningMsg    guifg=#b3a27a
hi Whitespace    guifg=#172532
hi WildMenu      guifg=#c5c9c7 guibg=#262b2f
hi WinBar        guifg=#5f605f guibg=#090e13 gui=bold
hi WinBarNC      guifg=#5f605f guibg=#090e13 gui=bold
hi Menu          guifg=#c5c9c7 guibg=#090e13
hi Scrollbar     guibg=#090e13
hi Tooltip       guifg=#c5c9c7 guibg=#040608

hi SpellBad   gui=undercurl guisp=#d17f79
hi SpellCap   gui=undercurl guisp=#b3a27a
hi SpellLocal gui=undercurl guisp=#8ba4b0
hi SpellRare  gui=undercurl guisp=#8ba4b0

hi DiffAdd    guibg=#4a5447
hi DiffChange guibg=#4a5962
hi DiffDelete guibg=#6d4746
hi DiffText   guibg=#46434d

hi Comment        guifg=#7a7e7f
hi Constant       guifg=#d98b71
hi String         guifg=#8a9a7b
hi Character      guifg=#8a9a7b
hi Number         guifg=#c3917a
hi Boolean        guifg=#c3917a
hi Float          guifg=#c3917a
hi Identifier     guifg=#8ea4a2
hi Function       guifg=#7fb4ca
hi Statement      guifg=#a292a3
hi Conditional    guifg=#938aa9
hi Repeat         guifg=#938aa9
hi Label          guifg=#938aa9
hi Operator       guifg=#8e918f
hi Keyword        guifg=#a292a3
hi Exception      guifg=#a292a3
hi PreProc        guifg=#c18486
hi Include        guifg=#c18486
hi Define         guifg=#c18486
hi Macro          guifg=#c18486
hi PreCondit      guifg=#c18486
hi Type           guifg=#b3a27a
hi StorageClass   guifg=#b3a27a
hi Structure      guifg=#b3a27a
hi Typedef        guifg=#b3a27a
hi Special        guifg=#7fb4ca
hi SpecialChar    guifg=#7fb4ca
hi Tag            guifg=#7fb4ca
hi Delimiter      guifg=#7fb4ca
hi SpecialComment guifg=#7fb4ca
hi Debug          guifg=#7fb4ca
hi Underlined     guifg=#7fb4ca gui=underline
hi Ignore         guifg=#101922
hi Error          guifg=#d17f79
hi Todo           guifg=#090e13 guibg=#8ba4b0

hi qfLineNr      guifg=#5f605f
hi qfFileName    guifg=#7fb4ca

hi diffAdded     guifg=#8a9a7b
hi diffRemoved   guifg=#d17f79
hi diffChanged   guifg=#8ba4b0
hi diffOldFile   guifg=#b3a27a
hi diffNewFile   guifg=#8a9a7b
hi diffFile      guifg=#8ba4b0
hi diffLine      guifg=#d98b71
hi diffIndexLine guifg=#c18486
" recol:end
