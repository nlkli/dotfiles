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
let g:colors_name = "TokyoNight"
set background=dark

hi Normal        guifg=#c0caf5 guibg=#1a1b26
hi NormalNC      guifg=#c0caf5 guibg=#1a1b26
hi Terminal      guifg=#c0caf5 guibg=#1a1b26
hi ColorColumn   guibg=#242635
hi Conceal       guifg=#464866
hi Cursor        guifg=#15161e guibg=#c0caf5
hi lCursor       guifg=#15161e guibg=#c0caf5
hi CursorIM      guifg=#15161e guibg=#c0caf5
hi CursorColumn  guibg=#303246
hi CursorLine    guibg=#303246
hi Directory     guifg=#7aa2f7
hi EndOfBuffer   guifg=#1a1b26
hi ErrorMsg      guifg=#f7768e
hi VertSplit     guifg=#12131b
hi WinSeparator  guifg=#12131b
hi Folded        guifg=#6e748c guibg=#242635
hi FoldColumn    guifg=#6e748c
hi SignColumn    guifg=#6e748c
hi Substitute    guifg=#1a1b26 guibg=#f7768e
hi LineNr        guifg=#6e748c
hi CursorLineNr  guifg=#e0af68 gui=bold
hi MatchParen    guifg=#e0af68 gui=bold
hi ModeMsg       guifg=#e0af68 gui=bold
hi MoreMsg       guifg=#7aa2f7 gui=bold
hi Question      guifg=#7aa2f7 gui=bold
hi NonText       guifg=#464866
hi SpecialKey    guifg=#464866
hi Pmenu         guifg=#c0caf5 guibg=#343646
hi PmenuSel      guifg=#c0caf5 guibg=#343646
hi PmenuSbar     guibg=#343646
hi PmenuThumb    guibg=#343646
hi QuickFixLine  guibg=#303246
hi Search        guifg=#c0caf5 guibg=#343646
hi IncSearch     guifg=#1a1b26 guibg=#9ece6a
hi CurSearch     guifg=#1a1b26 guibg=#9ece6a
hi StatusLine       guifg=#949cbd guibg=#12131b
hi StatusLineNC     guifg=#6e748c guibg=#12131b
hi StatusLineTerm   guifg=#949cbd guibg=#12131b
hi StatusLineTermNC guifg=#6e748c guibg=#12131b
hi TabLine       guifg=#949cbd guibg=#242635
hi TabLineFill   guibg=#12131b
hi TabLineSel    guifg=#1a1b26 guibg=#6e748c
hi Title         guifg=#7aa2f7 gui=bold
hi Visual        guibg=#343646
hi VisualNOS     guibg=#343646
hi WarningMsg    guifg=#e0af68
hi Whitespace    guifg=#303246
hi WildMenu      guifg=#c0caf5 guibg=#343646
hi WinBar        guifg=#6e748c guibg=#1a1b26 gui=bold
hi WinBarNC      guifg=#6e748c guibg=#1a1b26 gui=bold
hi Menu          guifg=#c0caf5 guibg=#1a1b26
hi Scrollbar     guibg=#1a1b26
hi Tooltip       guifg=#c0caf5 guibg=#12131b

hi SpellBad   gui=undercurl guisp=#f7768e
hi SpellCap   gui=undercurl guisp=#e0af68
hi SpellLocal gui=undercurl guisp=#7aa2f7
hi SpellRare  gui=undercurl guisp=#7aa2f7

hi DiffAdd    guibg=#5c7548
hi DiffChange guibg=#4a5f8f
hi DiffDelete guibg=#89495a
hi DiffText   guibg=#5a4e7a

hi Comment        guifg=#7e84a2
hi Constant       guifg=#ed957c
hi String         guifg=#9ece6a
hi Character      guifg=#9ece6a
hi Number         guifg=#ed957c
hi Boolean        guifg=#ed957c
hi Float          guifg=#ed957c
hi Identifier     guifg=#7dcfff
hi Function       guifg=#7aa2f7
hi Statement      guifg=#bb9af7
hi Conditional    guifg=#bb9af7
hi Repeat         guifg=#bb9af7
hi Label          guifg=#bb9af7
hi Operator       guifg=#949cbd
hi Keyword        guifg=#bb9af7
hi Exception      guifg=#bb9af7
hi PreProc        guifg=#d191ae
hi Include        guifg=#d191ae
hi Define         guifg=#d191ae
hi Macro          guifg=#d191ae
hi PreCondit      guifg=#d191ae
hi Type           guifg=#e0af68
hi StorageClass   guifg=#e0af68
hi Structure      guifg=#e0af68
hi Typedef        guifg=#e0af68
hi Special        guifg=#7aa2f7
hi SpecialChar    guifg=#7aa2f7
hi Tag            guifg=#7aa2f7
hi Delimiter      guifg=#7aa2f7
hi SpecialComment guifg=#7aa2f7
hi Debug          guifg=#7aa2f7
hi Underlined     guifg=#7aa2f7 gui=underline
hi Ignore         guifg=#242635
hi Error          guifg=#f7768e
hi Todo           guifg=#1a1b26 guibg=#7aa2f7

hi qfLineNr      guifg=#6e748c
hi qfFileName    guifg=#7aa2f7

hi diffAdded     guifg=#9ece6a
hi diffRemoved   guifg=#f7768e
hi diffChanged   guifg=#7aa2f7
hi diffOldFile   guifg=#e0af68
hi diffNewFile   guifg=#9ece6a
hi diffFile      guifg=#7aa2f7
hi diffLine      guifg=#ed957c
hi diffIndexLine guifg=#d191ae
" recol:end
