local opt = vim.opt

opt.number = true         -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = false    -- Highlight current line
opt.wrap = true           -- Wrap lines
opt.scrolloff = 4         -- Keep _ lines above/below cursor
opt.sidescrolloff = 4     -- Keep _ columns left/right of cursor

opt.termguicolors = true
opt.winborder = "rounded"
opt.showmatch = true      -- Highlight matching brackets
opt.matchtime = 2         -- How long to show matching bracket
opt.guicursor = "i:block" -- Use block cursor in insert mode
opt.signcolumn = "yes"

opt.tabstop = 4                               -- Tab width
opt.shiftwidth = 4                            -- Indent width
opt.softtabstop = 4                           -- Soft tab stop
opt.expandtab = true                          -- Use spaces instead of tabs
opt.smartindent = true                        -- Smart auto-indenting
opt.autoindent = true                         -- Copy indent from current line

opt.ignorecase = true                         -- Case insensitive search
opt.smartcase = true                          -- Case sensitive if uppercase in search
opt.hlsearch = false                          -- Don't highlight search results
opt.incsearch = true                          -- Show matches as you type

opt.hidden = true                             -- Allow hidden buffers
opt.backspace = "indent,eol,start"            -- Better backspace behavior
opt.errorbells = false                        -- No error bells
opt.belloff = "all"
opt.mouse = "a"                               -- Enable mouse support
opt.modifiable = true                         -- Allow buffer modifications
opt.encoding = "UTF-8"                        -- Set encoding

opt.backup = false                            -- Don't create backup files
opt.writebackup = false                       -- Don't create backup before writing
opt.swapfile = false                          -- Don't create swap files
opt.undofile = true                           -- Persistent undo
opt.undolevels = 10000
opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory

-- Create undo directory if it doesn't exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end

opt.updatetime = 300 -- Faster completion
opt.timeoutlen = 500 -- Lower than default (1000) to quickly trigger which-key
opt.ttimeoutlen = 0  -- Key code timeout
opt.autoread = true  -- Auto reload files changed outside vim
opt.autowrite = true -- Auto save

opt.synmaxcol = 300  -- Syntax highlighting limit
opt.redrawtime = 10000
opt.maxmempattern = 20000

opt.smoothscroll = true
vim.wo.foldmethod = "expr"
opt.foldlevel = 99             -- Start with all folds open
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Command-line completion
opt.wildmenu = true
opt.wildmode = "longest:full,full"

opt.linebreak = true

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1
vim.g.netrw_sizestyle = "H"

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = false,
    update_in_insert = false,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})

-- New UI opt-in
require('vim._core.ui2').enable({}) -- g< : go in, q : exit

vim.opt.langmap =
    "ёй,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ]," ..
    "фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э'," ..
    "яz,чx,сc,мv,иb,тn,ьm,ё`," ..
    "ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ}," ..
    "ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\\:,Э\"," ..
    "ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Ё~"
vim.opt.langremap = true

vim.g.mapleader = " "
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p')
vim.keymap.set({ "n", "x" }, "<leader>P", '"+P')
vim.keymap.set("n", "<leader>q", ":x<CR>")
vim.keymap.set("n", "<leader>w", ":update<CR>")
vim.keymap.set("n", "<leader>e", ":edit %:h<CR>")
vim.keymap.set("n", "<leader>E", ":edit .<CR>")
vim.keymap.set("n", "<leader>r", ":edit #<CR>")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])
vim.keymap.set("x", "<leader>s", [[y:%s/<C-r>"//g<Left><Left>]])
vim.keymap.set("n", "<leader>o", ":copen<CR>")
vim.keymap.set("n", "<leader>lo", ":lopen<CR>")
vim.keymap.set("n", "<leader>n", ":cnext<CR>")
vim.keymap.set("n", "<leader>N", ":cprev<CR>")
vim.keymap.set("n", "<leader>ln", ":lnext<CR>")
vim.keymap.set("n", "<leader>lN", ":lprev<CR>")
vim.keymap.set("n", "<leader>c", ":cclose | lclose<CR>")
vim.keymap.set("n", "<leader>t", ":tabnew | edit .<CR>")
vim.keymap.set("n", "<leader>T", ":tabnew | terminal<CR>")
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>O", ":Oil<CR>")
vim.keymap.set("n", "<leader>R", ":restart<CR>")
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>D", vim.diagnostic.setqflist)
vim.keymap.set("n", "<leader>d", function()
    vim.diagnostic.open_float({ scope = "line" })
end)

vim.keymap.set({ "n", "x" }, "<leader>н", '"+y')
vim.keymap.set({ "n", "x" }, "<leader>з", '"+p')
vim.keymap.set({ "n", "x" }, "<leader>З", '"+P')
vim.keymap.set("n", "<leader>й", ":x<CR>")
vim.keymap.set("n", "<leader>ц", ":update<CR>")
vim.keymap.set("n", "<leader>у", ":edit %:h<CR>")
vim.keymap.set("n", "<leader>У", ":edit .<CR>")
vim.keymap.set("n", "<leader>к", ":edit #<CR>")
vim.keymap.set("n", "<leader>ы", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])
vim.keymap.set("x", "<leader>ы", [[y:%s/<C-r>"//g<Left><Left>]])
vim.keymap.set("n", "<leader>щ", ":copen<CR>")
vim.keymap.set("n", "<leader>дщ", ":lopen<CR>")
vim.keymap.set("n", "<leader>т", ":cnext<CR>")
vim.keymap.set("n", "<leader>Т", ":cprev<CR>")
vim.keymap.set("n", "<leader>дт", ":lnext<CR>")
vim.keymap.set("n", "<leader>дТ", ":lprev<CR>")
vim.keymap.set("n", "<leader>с", ":cclose | lclose<CR>")
vim.keymap.set("n", "<leader>е", ":tabnew | edit .<CR>")
vim.keymap.set("n", "<leader>Е", ":tabnew | terminal<CR>")
vim.keymap.set("n", "<leader>а", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>Щ", ":Oil<CR>")
vim.keymap.set("n", "<leader>К", ":restart<CR>")
vim.keymap.set("n", "пв", vim.lsp.buf.definition)
vim.keymap.set("n", "пВ", vim.lsp.buf.declaration)
vim.keymap.set("n", "пк", vim.lsp.buf.references)
vim.keymap.set("n", "пш", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>В", vim.diagnostic.setqflist)
vim.keymap.set("n", "<leader>в", function()
    vim.diagnostic.open_float({ scope = "line" })
end)

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { buffer = true })
    end,
})

if vim.fn.executable("rg") == 1 then
    vim.api.nvim_create_user_command("Rg", function(opts)
        if opts.args == "" then return end
        local results = vim.fn.systemlist({ "rg", "--vimgrep", opts.args })
        if #results == 0 then return end
        vim.fn.setqflist({}, " ", {
            lines = results,
            efm = "%f:%l:%c:%m",
            title = "rg: " .. opts.args,
        })
        vim.cmd("copen")
    end, { nargs = "*", complete = "file" })
    vim.keymap.set("n", "<leader>g", ":Rg ")
end
if vim.fn.executable("fd") == 1 then
    vim.api.nvim_create_user_command("Fd", function(opts)
        if opts.args == "" then return end
        local results = vim.fn.systemlist({ "fd", opts.args })
        if #results == 0 then return end
        vim.fn.setloclist(0, {}, " ", {
            lines = results,
            efm = "%f",
            title = "fd: " .. opts.args,
        })
        vim.cmd("lopen")
    end, { nargs = "*", complete = "file" })
    vim.keymap.set("n", "<leader>f", ":Fd ")
end

vim.api.nvim_create_user_command("PackAdd", function(opts)
    vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (:PackAdd user/repo1 user/repo2)" })

-- Pack Delete and Update cmds are built-in on Nightly 0.13
vim.api.nvim_create_user_command("PackDel", function(opts)
    vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackDel plugin1 plugin2)" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
    -- checks if any argument is passed
    if opts.args:match("%S") then
        -- update specific plugins
        local plugins = vim.split(opts.args, "%s+", { trimempty = true })
        -- update only specified plugins
        vim.pack.update(plugins)
    else
        -- update all
        vim.pack.update()
    end
end, { nargs = "*", desc = "Update all plugins or specific ones" })

vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require("oil").setup({
    default_file_explorer = false,
    view_options = {
        show_hidden = true,
    }
})

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
local treesitter_parsers = {
    "bash",
    "c",
    "css",
    "csv",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "python",
    "rust",
    "toml",
}

local lspservers_ensure_installed = {
    "lua_ls",
    "html",
    "vtsls",
    "pyright",
    "rust_analyzer",
    "gopls",
    "jsonls",
    "clangd",
}

if #treesitter_parsers > 0 then
    vim.pack.add({
        { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    })
    require("nvim-treesitter").install(treesitter_parsers)
end

if #lspservers_ensure_installed > 0 then
    vim.pack.add({
        "https://github.com/mason-org/mason.nvim",
        "https://github.com/neovim/nvim-lspconfig",
        "https://github.com/mason-org/mason-lspconfig.nvim",
        "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
        "https://github.com/rafamadriz/friendly-snippets",
        "https://github.com/saghen/blink.lib",
        "https://github.com/saghen/blink.cmp",
    })

    require("mason").setup()
    require("mason-lspconfig").setup({
        automatic_enable = true,
    })
    require("mason-tool-installer").setup({
        ensure_installed = lspservers_ensure_installed,
    })

    local cmp = require("blink.cmp")
    cmp.build():wait(60000)

    cmp.setup({
        keymap = {
            preset = "default",
            ["<C-space>"] = {},
            ["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
        },
        signature = { enabled = true },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
        },
        fuzzy = { implementation = "rust" }, -- lua
    })
end

-- [STARTRECOLMARK]

-- Black Metal (Khold)

local function applyRecol()
    vim.cmd("highlight clear")
    if vim.fn.has("syntax_on") then vim.cmd("syntax reset") end

    local P = {
        black       = { "#000000", "#000000", "#000000" },
        red         = { "#5f8787", "#5f8787", "#517373" },
        green       = { "#eceee3", "#eceee3", "#c9cac1" },
        yellow      = { "#974b46", "#974b46", "#80403c" },
        blue        = { "#888888", "#888888", "#747474" },
        magenta     = { "#999999", "#999999", "#828282" },
        cyan        = { "#aaaaaa", "#aaaaaa", "#919191" },
        white       = { "#c1c1c1", "#c1c1c1", "#a4a4a4" },
        orange      = { "#7b6967", "#7b6967", "#695957" },
        pink        = { "#90a4a4", "#90a4a4", "#7a8b8b" },
        bg          = { "#0b0b0b", "#000000", "#0f0f0f", "#1f1f1f", "#3b3b3b" },
        fg          = { "#d0d0d0", "#c1c1c1", "#868686", "#515151" },
        sel         = { "#1d1d1d", "#2e2e2e" },
        cur         = {
            bg = "#c1c1c1",
            fg = "#8e8e8e",
        },
        comment     = "#747474",
        status_line = "#0b0b0b",
        diff        = {
            add = "#9e9f98",
            delete = "#405a5a",
            change = "#5b5b5b",
            text = "#5c5c5c",
        }
    }

    local spec = {
        diag = {
            error = P.red[1],
            warn  = P.yellow[1],
            info  = P.blue[1],
            hint  = P.green[1],
            ok    = P.green[1],
        },
        git = {
            add      = P.green[1],
            removed  = P.red[1],
            changed  = P.blue[1],
            conflict = P.yellow[1],
            ignored  = P.comment,
        }
    }
    local syn = {
        bracket     = P.fg[3],
        builtin0    = P.red[1],
        builtin1    = P.cyan[2],
        builtin2    = P.orange[2],
        builtin3    = P.red[2],
        comment     = P.comment,
        conditional = P.magenta[2],
        const       = P.orange[2],
        dep         = P.fg[4],
        field       = P.blue[1],
        func        = P.blue[2],
        ident       = P.cyan[1],
        keyword     = P.magenta[1],
        number      = P.orange[1],
        operator    = P.fg[3],
        preproc     = P.pink[2],
        regex       = P.yellow[2],
        statement   = P.magenta[1],
        string      = P.green[1],
        type        = P.yellow[1],
        variable    = P.fg[2],
    }
    local trans = false
    local inactive = false
    local inv = {
        match_paren = false,
        visual = false,
        search = false,
    }
    local stl = {
        comments = "NONE",
        conditionals = "NONE",
        constants = "NONE",
        functions = "NONE",
        keywords = "NONE",
        numbers = "NONE",
        operators = "NONE",
        preprocs = "NONE",
        strings = "NONE",
        types = "NONE",
        variables = "NONE",
    }

    for group, opts in pairs({
        ColorColumn                       = { bg = P.bg[3] },
        Conceal                           = { fg = P.bg[5] },
        Cursor                            = { fg = P.cur.fg, bg = P.cur.bg },
        lCursor                           = { link = "Cursor" },
        CursorIM                          = { link = "Cursor" },
        CursorColumn                      = { link = "CursorLine" },
        CursorLine                        = { bg = P.bg[4] },
        Directory                         = { fg = syn.func },
        DiffAdd                           = { bg = P.diff.add },
        DiffChange                        = { bg = P.diff.change },
        DiffDelete                        = { bg = P.diff.delete },
        DiffText                          = { bg = P.diff.text },
        EndOfBuffer                       = { fg = P.bg[2] },
        ErrorMsg                          = { fg = spec.diag.error },
        WinSeparator                      = { fg = P.bg[1] },
        VertSplit                         = { link = "WinSeparator" },
        Folded                            = { fg = P.fg[4], bg = P.bg[3] },
        FoldColumn                        = { fg = P.fg[4] },
        SignColumn                        = { fg = P.fg[4] },
        SignColumnSB                      = { link = "SignColumn" },
        Substitute                        = { fg = P.bg[2], bg = spec.diag.error },
        LineNr                            = { fg = P.fg[4] },
        CursorLineNr                      = { fg = spec.diag.warn, style = "bold" },
        MatchParen                        = { fg = spec.diag.warn, style = inv.match_paren and "reverse,bold" or "bold" },
        ModeMsg                           = { fg = spec.diag.warn, style = "bold" },
        MoreMsg                           = { fg = spec.diag.info, style = "bold" },
        NonText                           = { fg = P.bg[5] },
        Normal                            = { fg = P.fg[2], bg = trans and "NONE" or P.bg[2] },
        NormalNC                          = { fg = P.fg[2], bg = (inactive and P.bg[1]) or (trans and "NONE") or P.bg[2] },
        NormalFloat                       = { fg = P.fg[2], bg = P.bg[1] },
        FloatBorder                       = { fg = P.fg[4] },
        Pmenu                             = { fg = P.fg[2], bg = P.sel[1] },
        PmenuSel                          = { bg = P.sel[2] },
        PmenuSbar                         = { link = "Pmenu" },
        PmenuThumb                        = { bg = P.sel[2] },
        Question                          = { link = "MoreMsg" },
        QuickFixLine                      = { link = "CursorLine" },
        Search                            = inv.search and { style = "reverse" } or { fg = P.fg[2], bg = P.sel[2] },
        IncSearch                         = inv.search and { style = "reverse" } or { fg = P.bg[2], bg = spec.diag.hint },
        CurSearch                         = { link = "IncSearch" },
        SpecialKey                        = { link = "NonText" },
        SpellBad                          = { sp = spec.diag.error, style = "undercurl" },
        SpellCap                          = { sp = spec.diag.warn, style = "undercurl" },
        SpellLocal                        = { sp = spec.diag.info, style = "undercurl" },
        SpellRare                         = { sp = spec.diag.info, style = "undercurl" },
        StatusLine                        = { fg = P.fg[3], bg = P.status_line },
        StatusLineNC                      = { fg = P.fg[4], bg = P.status_line },
        TabLine                           = { fg = P.fg[3], bg = P.bg[3] },
        TabLineFill                       = { bg = P.bg[1] },
        TabLineSel                        = { fg = P.bg[2], bg = P.fg[4] },
        Title                             = { fg = syn.func, style = "bold" },
        Visual                            = inv.visual and { style = "reverse" } or { bg = P.sel[1] },
        VisualNOS                         = inv.visual and { style = "reverse" } or { link = "visual" },
        WarningMsg                        = { fg = spec.diag.warn },
        Whitespace                        = { fg = P.bg[4] },
        WildMenu                          = { link = "Pmenu" },
        WinBar                            = { fg = P.fg[4], bg = trans and "NONE" or P.bg[2], style = "bold" },
        WinBarNC                          = { fg = P.fg[4], bg = trans and "NONE" or inactive and P.bg[1] or P.bg[2], style = "bold" },

        Comment                           = { fg = syn.comment, style = stl.comments },
        Constant                          = { fg = syn.const, style = stl.constants },
        String                            = { fg = syn.string, style = stl.strings },
        Character                         = { link = "String" },
        Number                            = { fg = syn.number, style = stl.numbers },
        Float                             = { link = "Number" },
        Boolean                           = { link = "Number" },
        Identifier                        = { fg = syn.ident, style = stl.variables },
        Function                          = { fg = syn.func, style = stl.functions },
        Statement                         = { fg = syn.keyword, style = stl.keywords },
        Conditional                       = { fg = syn.conditional, style = stl.conditionals },
        Repeat                            = { link = "Conditional" },
        Label                             = { link = "Conditional" },
        Operator                          = { fg = syn.operator, style = stl.operators },
        Keyword                           = { fg = syn.keyword, style = stl.keywords },
        Exception                         = { link = "Keyword" },
        PreProc                           = { fg = syn.preproc, style = stl.preprocs },
        Include                           = { link = "PreProc" },
        Define                            = { link = "PreProc" },
        Macro                             = { link = "PreProc" },
        PreCondit                         = { link = "PreProc" },
        Type                              = { fg = syn.type, style = stl.types },
        StorageClass                      = { link = "Type" },
        Structure                         = { link = "Type" },
        Typedef                           = { link = "Type" },
        Special                           = { fg = syn.func },
        SpecialChar                       = { link = "Special" },
        Tag                               = { link = "Special" },
        Delimiter                         = { link = "Special" },
        SpecialComment                    = { link = "Special" },
        Debug                             = { link = "Special" },
        Underlined                        = { style = "underline" },
        Bold                              = { style = "bold" },
        Italic                            = { style = "italic" },
        Error                             = { fg = spec.diag.error },
        Todo                              = { fg = P.bg[2], bg = spec.diag.info },
        qfLineNr                          = { link = "lineNr" },
        qfFileName                        = { link = "Directory" },
        diffAdded                         = { fg = spec.git.add },
        diffRemoved                       = { fg = spec.git.removed },
        diffChanged                       = { fg = spec.git.changed },
        diffOldFile                       = { fg = spec.diag.warn },
        diffNewFile                       = { fg = spec.diag.hint },
        diffFile                          = { fg = spec.diag.info },
        diffLine                          = { fg = syn.builtin2 },
        diffIndexLine                     = { fg = syn.preproc },

        DiagnosticError                   = { fg = spec.diag.error },
        DiagnosticWarn                    = { fg = spec.diag.warn },
        DiagnosticInfo                    = { fg = spec.diag.info },
        DiagnosticHint                    = { fg = spec.diag.hint },
        DiagnosticOk                      = { fg = spec.diag.ok },
        DiagnosticSignError               = { link = "DiagnosticError" },
        DiagnosticSignWarn                = { link = "DiagnosticWarn" },
        DiagnosticSignInfo                = { link = "DiagnosticInfo" },
        DiagnosticSignHint                = { link = "DiagnosticHint" },
        DiagnosticSignOk                  = { link = "DiagnosticOk" },
        DiagnosticUnderlineError          = { style = "undercurl", sp = spec.diag.error },
        DiagnosticUnderlineWarn           = { style = "undercurl", sp = spec.diag.warn },
        DiagnosticUnderlineInfo           = { style = "undercurl", sp = spec.diag.info },
        DiagnosticUnderlineHint           = { style = "undercurl", sp = spec.diag.hint },
        DiagnosticUnderlineOk             = { style = "undercurl", sp = spec.diag.ok },

        ["@variable"]                     = { fg = syn.variable, style = stl.variables },
        ["@variable.builtin"]             = { fg = syn.builtin0, style = stl.variables },
        ["@variable.parameter"]           = { fg = syn.builtin1, style = stl.variables },
        ["@variable.member"]              = { fg = syn.field },
        ["@constant"]                     = { link = "Constant" },
        ["@constant.builtin"]             = { fg = syn.builtin2, style = stl.keywords },
        ["@constant.macro"]               = { link = "Macro" },
        ["@module"]                       = { fg = syn.builtin1 },
        ["@label"]                        = { link = "Label" },
        ["@string"]                       = { link = "String" },
        ["@string.regexp"]                = { fg = syn.regex, style = stl.strings },
        ["@string.escape"]                = { fg = syn.regex, style = "bold" },
        ["@string.special"]               = { link = "Special" },
        ["@string.special.url"]           = { fg = syn.const, style = "italic,underline" },
        ["@character"]                    = { link = "Character" },
        ["@character.special"]            = { link = "SpecialChar" },
        ["@boolean"]                      = { link = "Boolean" },
        ["@number"]                       = { link = "Number" },
        ["@number.float"]                 = { link = "Float" },
        ["@type"]                         = { link = "Type" },
        ["@type.builtin"]                 = { fg = syn.builtin1, style = stl.types },
        ["@attribute"]                    = { link = "Constant" },
        ["@property"]                     = { fg = syn.field },
        ["@function"]                     = { link = "Function" },
        ["@function.builtin"]             = { fg = syn.builtin0, style = stl.functions },
        ["@function.macro"]               = { fg = syn.builtin0, style = stl.functions },
        ["@constructor"]                  = { fg = syn.ident },
        ["@operator"]                     = { link = "Operator" },
        ["@keyword"]                      = { link = "Keyword" },
        ["@keyword.function"]             = { fg = syn.keyword, style = stl.functions },
        ["@keyword.operator"]             = { fg = syn.operator, style = stl.operators },
        ["@keyword.import"]               = { link = "Include" },
        ["@keyword.storage"]              = { link = "StorageClass" },
        ["@keyword.repeat"]               = { link = "Repeat" },
        ["@keyword.return"]               = { fg = syn.builtin0, style = stl.keywords },
        ["@keyword.exception"]            = { link = "Exception" },
        ["@keyword.conditional"]          = { link = "Conditional" },
        ["@keyword.conditional.ternary"]  = { link = "Conditional" },
        ["@punctuation.delimiter"]        = { fg = syn.bracket },
        ["@punctuation.bracket"]          = { fg = syn.bracket },
        ["@punctuation.special"]          = { fg = syn.builtin1, style = stl.operators },
        ["@comment"]                      = { link = "Comment" },
        ["@comment.error"]                = { fg = P.bg[2], bg = spec.diag.error },
        ["@comment.warning"]              = { fg = P.bg[2], bg = spec.diag.warn },
        ["@comment.todo"]                 = { fg = P.bg[2], bg = spec.diag.hint },
        ["@comment.note"]                 = { fg = P.bg[2], bg = spec.diag.info },
        ["@markup"]                       = { fg = P.fg[2] },
        ["@markup.strong"]                = { fg = P.red[1], style = "bold" },
        ["@markup.italic"]                = { link = "Italic" },
        ["@markup.strikethrough"]         = { fg = P.fg[2], style = "strikethrough" },
        ["@markup.underline"]             = { link = "Underline" },
        ["@markup.heading"]               = { link = "Title" },
        ["@markup.quote"]                 = { fg = P.fg[3] },
        ["@markup.math"]                  = { fg = syn.func },
        ["@markup.link"]                  = { fg = syn.keyword, style = "bold" },
        ["@markup.link.label"]            = { link = "Special" },
        ["@markup.link.url"]              = { fg = syn.const, style = "italic,underline" },
        ["@markup.raw"]                   = { fg = syn.ident, style = "italic" },
        ["@markup.raw.block"]             = { fg = P.pink[1] },
        ["@markup.list"]                  = { fg = syn.builtin1, style = stl.operators },
        ["@markup.list.checked"]          = { fg = P.green[1] },
        ["@markup.list.unchecked"]        = { fg = P.yellow[1] },
        ["@diff.plus"]                    = { link = "diffAdded" },
        ["@diff.minus"]                   = { link = "diffRemoved" },
        ["@diff.delta"]                   = { link = "diffChanged" },
        ["@tag"]                          = { fg = syn.keyword },
        ["@tag.attribute"]                = { fg = syn.func, style = "italic" },
        ["@tag.delimiter"]                = { fg = syn.builtin1 },
        ["@label.json"]                   = { fg = syn.func },
        ["@constructor.lua"]              = { fg = P.fg[3] },
        ["@field.rust"]                   = { fg = P.fg[3] },
        ["@variable.member.yaml"]         = { fg = syn.func },

        ["@lsp.type.boolean"]             = { link = "@boolean" },
        ["@lsp.type.builtinType"]         = { link = "@type.builtin" },
        ["@lsp.type.comment"]             = { link = "@comment" },
        ["@lsp.type.enum"]                = { link = "@type" },
        ["@lsp.type.enumMember"]          = { link = "@constant" },
        ["@lsp.type.escapeSequence"]      = { link = "@string.escape" },
        ["@lsp.type.formatSpecifier"]     = { link = "@punctuation.special" },
        ["@lsp.type.interface"]           = { fg = syn.builtin3 },
        ["@lsp.type.keyword"]             = { link = "@keyword" },
        ["@lsp.type.namespace"]           = { link = "@module" },
        ["@lsp.type.number"]              = { link = "@number" },
        ["@lsp.type.operator"]            = { link = "@operator" },
        ["@lsp.type.parameter"]           = { link = "@parameter" },
        ["@lsp.type.property"]            = { link = "@property" },
        ["@lsp.type.selfKeyword"]         = { link = "@variable.builtin" },
        ["@lsp.type.typeAlias"]           = { link = "@type.definition" },
        ["@lsp.type.unresolvedReference"] = { link = "@error" },
    }) do
        if opts.style and opts.style ~= "NONE" then
            for token in opts.style:gmatch("[^,%s]+") do
                opts[token] = true
            end
        end
        opts.style = nil
        vim.api.nvim_set_hl(0, group, opts)
    end
end
applyRecol()

-- [ENDRECOLMARK]
