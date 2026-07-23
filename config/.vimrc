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
let g:colors_name = "Terafox"
set background=dark

hi Normal        guifg=#e6eaea guibg=#152528
hi NormalNC      guifg=#e6eaea guibg=#152528
hi Terminal      guifg=#e6eaea guibg=#152528
hi ColorColumn   guibg=#1d3337
hi Conceal       guifg=#345c63
hi Cursor        guifg=#152528 guibg=#e6eaea
hi lCursor       guifg=#152528 guibg=#e6eaea
hi CursorIM      guifg=#152528 guibg=#e6eaea
hi CursorColumn  guibg=#254247
hi CursorLine    guibg=#254247
hi Directory     guifg=#73a3b7
hi EndOfBuffer   guifg=#152528
hi ErrorMsg      guifg=#e85c51
hi VertSplit     guifg=#0f1b1d
hi WinSeparator  guifg=#0f1b1d
hi Folded        guifg=#787a7a guibg=#1d3337
hi FoldColumn    guifg=#787a7a
hi SignColumn    guifg=#787a7a
hi Substitute    guifg=#152528 guibg=#e85c51
hi LineNr        guifg=#787a7a
hi CursorLineNr  guifg=#fda47f gui=bold
hi MatchParen    guifg=#fda47f gui=bold
hi ModeMsg       guifg=#fda47f gui=bold
hi MoreMsg       guifg=#5a93aa gui=bold
hi Question      guifg=#5a93aa gui=bold
hi NonText       guifg=#345c63
hi SpecialKey    guifg=#345c63
hi Pmenu         guifg=#e6eaea guibg=#354446
hi PmenuSel      guifg=#e6eaea guibg=#354446
hi PmenuSbar     guibg=#354446
hi PmenuThumb    guibg=#354446
hi QuickFixLine  guibg=#254247
hi Search        guifg=#e6eaea guibg=#354446
hi IncSearch     guifg=#152528 guibg=#7aa4a1
hi CurSearch     guifg=#152528 guibg=#7aa4a1
hi StatusLine       guifg=#acafaf guibg=#0f1b1d
hi StatusLineNC     guifg=#787a7a guibg=#0f1b1d
hi StatusLineTerm   guifg=#acafaf guibg=#0f1b1d
hi StatusLineTermNC guifg=#787a7a guibg=#0f1b1d
hi TabLine       guifg=#acafaf guibg=#1d3337
hi TabLineFill   guibg=#0f1b1d
hi TabLineSel    guifg=#152528 guibg=#787a7a
hi Title         guifg=#73a3b7 gui=bold
hi Visual        guibg=#354446
hi VisualNOS     guibg=#354446
hi WarningMsg    guifg=#fda47f
hi Whitespace    guifg=#254247
hi WildMenu      guifg=#e6eaea guibg=#354446
hi WinBar        guifg=#787a7a guibg=#152528 gui=bold
hi WinBarNC      guifg=#787a7a guibg=#152528 gui=bold
hi Menu          guifg=#e6eaea guibg=#152528
hi Scrollbar     guibg=#152528
hi Tooltip       guifg=#e6eaea guibg=#0f1b1d

hi SpellBad   gui=undercurl guisp=#e85c51
hi SpellCap   gui=undercurl guisp=#fda47f
hi SpellLocal gui=undercurl guisp=#5a93aa
hi SpellRare  gui=undercurl guisp=#5a93aa

hi DiffAdd    guibg=#577877
hi DiffChange guibg=#426d7d
hi DiffDelete guibg=#9e4943
hi DiffText   guibg=#70465a

hi Comment        guifg=#929b9c
hi Constant       guifg=#f4937f
hi String         guifg=#7aa4a1
hi Character      guifg=#7aa4a1
hi Number         guifg=#f38068
hi Boolean        guifg=#f38068
hi Float          guifg=#f38068
hi Identifier     guifg=#a1cdd8
hi Function       guifg=#73a3b7
hi Statement      guifg=#ad5c7c
hi Conditional    guifg=#b97490
hi Repeat         guifg=#b97490
hi Label          guifg=#b97490
hi Operator       guifg=#acafaf
hi Keyword        guifg=#ad5c7c
hi Exception      guifg=#ad5c7c
hi PreProc        guifg=#edb1ad
hi Include        guifg=#edb1ad
hi Define         guifg=#edb1ad
hi Macro          guifg=#edb1ad
hi PreCondit      guifg=#edb1ad
hi Type           guifg=#fda47f
hi StorageClass   guifg=#fda47f
hi Structure      guifg=#fda47f
hi Typedef        guifg=#fda47f
hi Special        guifg=#73a3b7
hi SpecialChar    guifg=#73a3b7
hi Tag            guifg=#73a3b7
hi Delimiter      guifg=#73a3b7
hi SpecialComment guifg=#73a3b7
hi Debug          guifg=#73a3b7
hi Underlined     guifg=#73a3b7 gui=underline
hi Ignore         guifg=#1d3337
hi Error          guifg=#e85c51
hi Todo           guifg=#152528 guibg=#5a93aa

hi qfLineNr      guifg=#787a7a
hi qfFileName    guifg=#73a3b7

hi diffAdded     guifg=#7aa4a1
hi diffRemoved   guifg=#e85c51
hi diffChanged   guifg=#5a93aa
hi diffOldFile   guifg=#fda47f
hi diffNewFile   guifg=#7aa4a1
hi diffFile      guifg=#5a93aa
hi diffLine      guifg=#f4937f
hi diffIndexLine guifg=#edb1ad
" recol:end
