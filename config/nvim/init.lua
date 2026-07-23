local opt = vim.opt

-- UI
opt.number = true         -- Line numbers
opt.relativenumber = true -- Relative line numbers
opt.cursorline = false    -- Highlight current line
opt.wrap = true           -- Wrap lines
opt.scrolloff = 4         -- Keep 4 lines above/below cursor
opt.sidescrolloff = 4     -- Keep 4 columns left/right of cursor
opt.termguicolors = true
opt.winborder = "rounded"
opt.showmatch = true      -- Highlight matching brackets
opt.matchtime = 2         -- How long to show matching bracket
opt.guicursor = "i:block" -- Use block cursor in insert mode
opt.signcolumn = "yes"

-- Indentation
opt.tabstop = 4        -- Tab width
opt.shiftwidth = 4     -- Indent width
opt.softtabstop = 4    -- Soft tab stop
opt.expandtab = true   -- Use spaces instead of tabs
opt.smartindent = true -- Smart auto-indenting
opt.autoindent = true  -- Copy indent from current line

-- Search
opt.ignorecase = true -- Case insensitive search
opt.smartcase = true  -- Case sensitive if uppercase in search
opt.hlsearch = false  -- Don't highlight search results
opt.incsearch = true  -- Show matches as you type

-- Editing behavior
opt.hidden = true                  -- Allow hidden buffers
opt.backspace = "indent,eol,start" -- Better backspace behavior
opt.errorbells = false             -- No error bells
opt.belloff = "all"
opt.mouse = "a"                    -- Enable mouse support
opt.modifiable = true              -- Allow buffer modifications
opt.encoding = "UTF-8"             -- Set encoding
opt.autoread = true                -- Auto reload files changed outside vim
opt.autowrite = true               -- Auto save

-- Backup / undo
opt.backup = false                            -- Don't create backup files
opt.writebackup = false                       -- Don't create backup before writing
opt.swapfile = false                          -- Don't create swap files
opt.undofile = true                           -- Persistent undo
opt.undolevels = 10000
opt.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory

if vim.fn.isdirectory(opt.undodir:get()[1]) == 0 then
    vim.fn.mkdir(opt.undodir:get()[1], "p")
end

-- Performance
opt.updatetime = 300 -- Faster completion
opt.timeoutlen = 500 -- Lower than default (1000) to quickly trigger which-key
opt.ttimeoutlen = 0  -- Key code timeout
opt.synmaxcol = 300  -- Syntax highlighting limit
opt.redrawtime = 10000
opt.maxmempattern = 20000
opt.smoothscroll = true

-- Folding
vim.wo.foldmethod = "expr"
opt.foldlevel = 99 -- Start with all folds open

-- Formatting / grep
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.linebreak = true

-- Command-line completion
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- netrw
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

-- New UI opt-in (g< : go in, q : exit)
require('vim._core.ui2').enable({})

vim.opt.langmap =
    "ёй,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ъ]," ..
    "фa,ыs,вd,аf,пg,рh,оj,лk,дl,ж\\;,э'," ..
    "яz,чx,сc,мv,иb,тn,ьm,ё`," ..
    "ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ъ}," ..
    "ФA,ЫS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж\\:,Э\"," ..
    "ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Ё~"
vim.opt.langremap = true


vim.g.mapleader = " "

local function diagnostic_float_line()
    vim.diagnostic.open_float({ scope = "line" })
end

-- <leader>-prefixed keymaps: { modes, key (without leader), rhs }
local leader_keymaps = {
    { { "n", "x" }, "y",  '"+y' },
    { { "n", "x" }, "p",  '"+p' },
    { { "n", "x" }, "P",  '"+P' },
    { "n",          "q",  ":x<CR>" },
    { "n",          "w",  ":update<CR>" },
    { "n",          "e",  ":edit %:h<CR>" },
    { "n",          "E",  ":edit .<CR>" },
    { "n",          "r",  ":edit #<CR>" },
    { "n",          "s",  [[:%s/\<<C-r><C-w>\>//g<Left><Left>]] },
    { "x",          "s",  [[y:%s/<C-r>"//g<Left><Left>]] },
    { "n",          "b",  ":bnext<CR>" },
    { "n",          "B",  ":bprev<CR>" },
    { "n",          "o",  ":copen<CR>" },
    { "n",          "l",  ":lopen<CR>" },
    { "n",          "n",  ":cnext<CR>" },
    { "n",          "N",  ":cprev<CR>" },
    { "n",          "ln", ":lnext<CR>" },
    { "n",          "lN", ":lprev<CR>" },
    { "n",          "c",  ":cclose | lclose<CR>" },
    { "n",          "t",  ":tabnew | edit .<CR>" },
    { "n",          "T",  ":tabnew | terminal<CR>" },
    { "n",          "F",  vim.lsp.buf.format },
    -- { "n",          "O",  ":Oil<CR>" },
    { "n",          "R",  ":source ~/.config/nvim/init.lua<CR>" },
    { "n",          "Re", ":restart<CR>" },
    { "n",          "D",  vim.diagnostic.setqflist },
    { "n",          "d",  diagnostic_float_line },
}

-- Russian layout equivalents (same rhs, key produced by langmap)
local leader_keymaps_ru = {
    { { "n", "x" }, "н", '"+y' },
    { { "n", "x" }, "з", '"+p' },
    { { "n", "x" }, "З", '"+P' },
    { "n", "й", ":x<CR>" },
    { "n", "ц", ":update<CR>" },
    { "n", "у", ":edit %:h<CR>" },
    { "n", "У", ":edit .<CR>" },
    { "n", "к", ":edit #<CR>" },
    { "n", "ы", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]] },
    { "x", "ы", [[y:%s/<C-r>"//g<Left><Left>]] },
    { "n", "и", ":bnext<CR>" },
    { "n", "И", ":bprev<CR>" },
    { "n", "щ", ":copen<CR>" },
    { "n", "д", ":lopen<CR>" },
    { "n", "т", ":cnext<CR>" },
    { "n", "Т", ":cprev<CR>" },
    { "n", "дт", ":lnext<CR>" },
    { "n", "дТ", ":lprev<CR>" },
    { "n", "с", ":cclose | lclose<CR>" },
    { "n", "е", ":tabnew | edit .<CR>" },
    { "n", "Е", ":tabnew | terminal<CR>" },
    { "n", "а", vim.lsp.buf.format },
    -- { "n", "Щ", ":Oil<CR>" },
    { "n", "К", ":source ~/.config/nvim/init.lua<CR>" },
    { "n", "Ку", ":restart<CR>" },
    { "n", "В", vim.diagnostic.setqflist },
    { "n", "в", diagnostic_float_line },
}

for _, m in ipairs(leader_keymaps) do
    vim.keymap.set(m[1], "<leader>" .. m[2], m[3])
end
for _, m in ipairs(leader_keymaps_ru) do
    vim.keymap.set(m[1], "<leader>" .. m[2], m[3])
end

-- LSP navigation (English + Russian layout)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "пв", vim.lsp.buf.definition)
vim.keymap.set("n", "пВ", vim.lsp.buf.declaration)
vim.keymap.set("n", "пк", vim.lsp.buf.references)
vim.keymap.set("n", "пш", vim.lsp.buf.implementation)

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { buffer = true })
    end,
})

if vim.fn.executable("rg") == 1 then
    vim.api.nvim_create_user_command("Rg", function(opts)
        if opts.args == "" then return end
        local cmd = { "rg", "--vimgrep" }
        vim.list_extend(cmd, vim.split(opts.args, "%s+"))
        local results = vim.fn.systemlist(cmd)
        if #results == 0 then return end
        vim.fn.setqflist({}, " ", {
            lines = results,
            efm = "%f:%l:%c:%m",
            title = "rg: " .. opts.args,
        })
        vim.cmd("copen")
    end, { nargs = "*" })
    vim.keymap.set("n", "<leader>g", ":Rg ")
end

if vim.fn.executable("fd") == 1 then
    vim.api.nvim_create_user_command("Fd", function(opts)
        if opts.args == "" then return end
        local cmd = { "fd" }
        vim.list_extend(cmd, vim.split(opts.args, "%s+"))
        local results = vim.fn.systemlist(cmd)
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

if vim.fn.executable("recol") == 1 then
    local function launch_interactive_mode()
        local width = math.floor(vim.o.columns * 0.75)
        local height = math.floor(vim.o.lines * 0.75)
        local buf = vim.api.nvim_create_buf(false, true)
        local win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = width,
            height = height,
            row = math.floor((vim.o.lines - height - 3) / 2),
            col = math.floor((vim.o.columns - width) / 2),
            border = "rounded",
            title = " Recol ",
            title_pos = "center",
        })
        vim.bo[buf].bufhidden = "wipe"
        vim.fn.termopen({ "recol", "-i", "--quit-on-select" }, {
            on_exit = function()
                vim.schedule(function()
                    if vim.api.nvim_win_is_valid(win) then
                        vim.api.nvim_win_close(win, true)
                    end
                    vim.cmd.source("~/.config/nvim/init.lua")
                end)
            end,
        })
        vim.cmd.startinsert()
    end

    vim.api.nvim_create_user_command("Recol", function(opts)
        local args = vim.split(opts.args, "%s+", { trimempty = true })
        local is_interactive_mode = vim.tbl_contains(args, "-i") or vim.tbl_contains(args, "--interactive")
        if is_interactive_mode then
            launch_interactive_mode()
            return
        end
        vim.cmd("!recol " .. opts.args)
        vim.cmd.source("~/.config/nvim/init.lua")
    end, { nargs = "*" })

    vim.api.nvim_create_user_command("RecolOpen", function()
        launch_interactive_mode()
    end, { nargs = 0 })

    vim.keymap.set("n", "<leader>x", function()
        local buf = vim.api.nvim_create_buf(false, true)
        local win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = 80,
            height = 20,
            row = 2,
            col = 4,
            border = "rounded",
        })
        vim.fn.termopen({ "recol", "-i" }, {
            on_exit = function()
                vim.schedule(function()
                    if vim.api.nvim_win_is_valid(win) then
                        vim.api.nvim_win_close(win, true)
                    end
                    vim.cmd("source ~/.config/nvim/init.lua")
                end)
            end,
        })
        vim.cmd.startinsert()
    end)
end

-- Pack Delete and Update commands are built-in on Nightly 0.13
vim.api.nvim_create_user_command("PackAdd", function(opts)
    vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins (:PackAdd user/repo1 user/repo2)" })

vim.api.nvim_create_user_command("PackDel", function(opts)
    vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins (:PackDel plugin1 plugin2)" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
    if opts.args:match("%S") then
        vim.pack.update(vim.split(opts.args, "%s+", { trimempty = true }))
    else
        vim.pack.update()
    end
end, { nargs = "*", desc = "Update all plugins or specific ones" })

-- File explorer
vim.pack.add({ "https://github.com/stevearc/oil.nvim" })
require("oil").setup({
    default_file_explorer = true,
    columns = {
        -- "icon",
        "permissions",
        "size",
        "mtime",
    },
    view_options = {
        show_hidden = true,
    },
    win_options = {
        wrap = true,
    },
    skip_confirm_for_simple_edits = true,
})

-- Treesitter
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

if #treesitter_parsers > 0 then
    vim.pack.add({
        { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    })
    require("nvim-treesitter").install(treesitter_parsers)

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
            -- Start highlighting only when a parser is available for this filetype
            pcall(vim.treesitter.start)
        end,
    })
end

-- LSP (mason + lspconfig + completion)
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

-- recol:start
-- Terafox
local function applyRecolTheme()
    vim.cmd("highlight clear")
    if vim.fn.has("syntax_on") then vim.cmd("syntax reset") end
    local P = {
        black   = { "#2f3239", "#4e5157", "#4f5258" },
        red     = { "#e85c51", "#eb746b", "#ec756c" },
        green   = { "#7aa4a1", "#8eb2af", "#8fb2b0" },
        yellow  = { "#fda47f", "#fdb292", "#fdb293" },
        blue    = { "#5a93aa", "#73a3b7", "#74a4b7" },
        magenta = { "#ad5c7c", "#b97490", "#ba7590" },
        cyan    = { "#a1cdd8", "#afd4de", "#b0d5de" },
        white   = { "#ebebeb", "#eeeeee", "#eeeeee" },
        orange  = { "#f38068", "#f4937f", "#f5947f" },
        pink    = { "#eaa49e", "#edb1ad", "#edb2ad" },
        bg = { "#0f1b1d", "#152528", "#1d3337", "#254247", "#345c63" },
        fg = { "#f5f9f9", "#e6eaea", "#acafaf", "#787a7a" },
        sel = { "#354446", "#354446" },
        cur = { 
            bg = "#e6eaea",
            fg = "#152528",
        },
        comment = "#929b9c",
        status_line = "#0f1b1d",
        diff = {
            add = "#577877",
            delete = "#9e4943",
            change = "#426d7d",
            text = "#70465a",
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
        ColorColumn  = { bg = P.bg[3] },
        Conceal      = { fg = P.bg[5] },
        Cursor       = { fg = P.cur.fg, bg = P.cur.bg },
        lCursor      = { link = "Cursor" },
        CursorIM     = { link = "Cursor" },
        CursorColumn = { link = "CursorLine" },
        CursorLine   = { bg = P.bg[4] },
        Directory    = { fg = syn.func },
        DiffAdd      = { bg = P.diff.add },
        DiffChange   = { bg = P.diff.change },
        DiffDelete   = { bg = P.diff.delete },
        DiffText     = { bg = P.diff.text },
        EndOfBuffer  = { fg = P.bg[2] },
        ErrorMsg     = { fg = spec.diag.error },
        WinSeparator = { fg = P.bg[1] },
        VertSplit    = { link = "WinSeparator" },
        Folded       = { fg = P.fg[4], bg = P.bg[3] },
        FoldColumn   = { fg = P.fg[4] },
        SignColumn   = { fg = P.fg[4] },
        SignColumnSB = { link = "SignColumn" },
        Substitute   = { fg = P.bg[2], bg = spec.diag.error },
        LineNr       = { fg = P.fg[4] },
        CursorLineNr = { fg = spec.diag.warn, style = "bold" },
        MatchParen   = { fg = spec.diag.warn, style = inv.match_paren and "reverse,bold" or "bold" },
        ModeMsg      = { fg = spec.diag.warn, style = "bold" },
        MoreMsg      = { fg = spec.diag.info, style = "bold" },
        NonText      = { fg = P.bg[5] },
        Normal       = { fg = P.fg[2], bg = trans and "NONE" or P.bg[2] },
        NormalNC     = { fg = P.fg[2], bg = (inactive and P.bg[1]) or (trans and "NONE") or P.bg[2] },
        NormalFloat  = { fg = P.fg[2], bg = P.bg[1] },
        FloatBorder  = { fg = P.fg[4] },
        Pmenu        = { fg = P.fg[2], bg = P.sel[1] },
        PmenuSel     = { bg = P.sel[2] },
        PmenuSbar    = { link = "Pmenu" },
        PmenuThumb   = { bg = P.sel[2] },
        Question     = { link = "MoreMsg" },
        QuickFixLine = { link = "CursorLine" },
        Search       = inv.search and { style = "reverse" } or { fg = P.fg[2], bg = P.sel[2] },
        IncSearch    = inv.search and { style = "reverse" } or { fg = P.bg[2], bg = spec.diag.hint },
        CurSearch    = { link = "IncSearch" },
        SpecialKey   = { link = "NonText" },
        SpellBad     = { sp = spec.diag.error, style = "undercurl" },
        SpellCap     = { sp = spec.diag.warn, style = "undercurl" },
        SpellLocal   = { sp = spec.diag.info, style = "undercurl" },
        SpellRare    = { sp = spec.diag.info, style = "undercurl" },
        StatusLine   = { fg = P.fg[3], bg = P.status_line },
        StatusLineNC = { fg = P.fg[4], bg = P.status_line },
        TabLine      = { fg = P.fg[3], bg = P.bg[3] },
        TabLineFill  = { bg = P.bg[1] },
        TabLineSel   = { fg = P.bg[2], bg = P.fg[4] },
        Title        = { fg = syn.func, style = "bold" },
        Visual       = inv.visual and { style = "reverse" } or { bg = P.sel[1] },
        VisualNOS    = inv.visual and { style = "reverse" } or { link = "Visual" },
        WarningMsg   = { fg = spec.diag.warn },
        Whitespace   = { fg = P.bg[4] },
        WildMenu     = { link = "Pmenu" },
        WinBar       = { fg = P.fg[4], bg = trans and "NONE" or P.bg[2], style = "bold" },
        WinBarNC     = { fg = P.fg[4], bg = trans and "NONE" or inactive and P.bg[1] or P.bg[2], style = "bold" },

        Comment        = { fg = syn.comment, style = stl.comments },
        Constant       = { fg = syn.const, style = stl.constants },
        String         = { fg = syn.string, style = stl.strings },
        Character      = { link = "String" },
        Number         = { fg = syn.number, style = stl.numbers },
        Float          = { link = "Number" },
        Boolean        = { link = "Number" },
        Identifier     = { fg = syn.ident, style = stl.variables },
        Function       = { fg = syn.func, style = stl.functions },
        Statement      = { fg = syn.keyword, style = stl.keywords },
        Conditional    = { fg = syn.conditional, style = stl.conditionals },
        Repeat         = { link = "Conditional" },
        Label          = { link = "Conditional" },
        Operator       = { fg = syn.operator, style = stl.operators },
        Keyword        = { fg = syn.keyword, style = stl.keywords },
        Exception      = { link = "Keyword" },
        PreProc        = { fg = syn.preproc, style = stl.preprocs },
        Include        = { link = "PreProc" },
        Define         = { link = "PreProc" },
        Macro          = { link = "PreProc" },
        PreCondit      = { link = "PreProc" },
        Type           = { fg = syn.type, style = stl.types },
        StorageClass   = { link = "Type" },
        Structure      = { link = "Type" },
        Typedef        = { link = "Type" },
        Special        = { fg = syn.func },
        SpecialChar    = { link = "Special" },
        Tag            = { link = "Special" },
        Delimiter      = { link = "Special" },
        SpecialComment = { link = "Special" },
        Debug          = { link = "Special" },
        Underlined     = { style = "underline" },
        Bold           = { style = "bold" },
        Italic         = { style = "italic" },
        Error          = { fg = spec.diag.error },
        Todo           = { fg = P.bg[2], bg = spec.diag.info },
        qfLineNr       = { link = "LineNr" },
        qfFileName     = { link = "Directory" },
        diffAdded      = { fg = spec.git.add },
        diffRemoved    = { fg = spec.git.removed },
        diffChanged    = { fg = spec.git.changed },
        diffOldFile    = { fg = spec.diag.warn },
        diffNewFile    = { fg = spec.diag.hint },
        diffFile       = { fg = spec.diag.info },
        diffLine       = { fg = syn.builtin2 },
        diffIndexLine  = { fg = syn.preproc },

        DiagnosticError          = { fg = spec.diag.error },
        DiagnosticWarn           = { fg = spec.diag.warn },
        DiagnosticInfo           = { fg = spec.diag.info },
        DiagnosticHint           = { fg = spec.diag.hint },
        DiagnosticOk             = { fg = spec.diag.ok },
        DiagnosticSignError      = { link = "DiagnosticError" },
        DiagnosticSignWarn       = { link = "DiagnosticWarn" },
        DiagnosticSignInfo       = { link = "DiagnosticInfo" },
        DiagnosticSignHint       = { link = "DiagnosticHint" },
        DiagnosticSignOk         = { link = "DiagnosticOk" },
        DiagnosticUnderlineError = { style = "undercurl", sp = spec.diag.error },
        DiagnosticUnderlineWarn  = { style = "undercurl", sp = spec.diag.warn },
        DiagnosticUnderlineInfo  = { style = "undercurl", sp = spec.diag.info },
        DiagnosticUnderlineHint  = { style = "undercurl", sp = spec.diag.hint },
        DiagnosticUnderlineOk    = { style = "undercurl", sp = spec.diag.ok },

        ["@variable"] = { fg = syn.variable, style = stl.variables },
        ["@variable.builtin"] = { fg = syn.builtin0, style = stl.variables },
        ["@variable.parameter"] = { fg = syn.builtin1, style = stl.variables },
        ["@variable.member"] = { fg = syn.field },
        ["@constant"] = { link = "Constant" },
        ["@constant.builtin"] = { fg = syn.builtin2, style = stl.keywords },
        ["@constant.macro"] = { link = "Macro" },
        ["@module"] = { fg = syn.builtin1 },
        ["@label"] = { link = "Label" },
        ["@string"] = { link = "String" },
        ["@string.regexp"] = { fg = syn.regex, style = stl.strings },
        ["@string.escape"] = { fg = syn.regex, style = "bold" },
        ["@string.special"] = { link = "Special" },
        ["@string.special.url"] = { fg = syn.const, style = "italic,underline" },
        ["@character"] = { link = "Character" },
        ["@character.special"] = { link = "SpecialChar" },
        ["@boolean"] = { link = "Boolean" },
        ["@number"] = { link = "Number" },
        ["@number.float"] = { link = "Float" },
        ["@type"] = { link = "Type" },
        ["@type.builtin"] = { fg = syn.builtin1, style = stl.types },
        ["@attribute"] = { link = "Constant" },
        ["@property"] = { fg = syn.field },
        ["@function"] = { link = "Function" },
        ["@function.builtin"] = { fg = syn.builtin0, style = stl.functions },
        ["@function.macro"] = { fg = syn.builtin0, style = stl.functions },
        ["@constructor"] = { fg = syn.ident },
        ["@operator"] = { link = "Operator" },
        ["@keyword"] = { link = "Keyword" },
        ["@keyword.function"] = { fg = syn.keyword, style = stl.functions },
        ["@keyword.operator"] = { fg = syn.operator, style = stl.operators },
        ["@keyword.import"] = { link = "Include" },
        ["@keyword.storage"] = { link = "StorageClass" },
        ["@keyword.repeat"] = { link = "Repeat" },
        ["@keyword.return"] = { fg = syn.builtin0, style = stl.keywords },
        ["@keyword.exception"] = { link = "Exception" },
        ["@keyword.conditional"] = { link = "Conditional" },
        ["@keyword.conditional.ternary"] = { link = "Conditional" },
        ["@punctuation.delimiter"] = { fg = syn.bracket },
        ["@punctuation.bracket"] = { fg = syn.bracket },
        ["@punctuation.special"] = { fg = syn.builtin1, style = stl.operators },
        ["@comment"] = { link = "Comment" },
        ["@comment.error"] = { fg = P.bg[2], bg = spec.diag.error },
        ["@comment.warning"] = { fg = P.bg[2], bg = spec.diag.warn },
        ["@comment.todo"] = { fg = P.bg[2], bg = spec.diag.hint },
        ["@comment.note"] = { fg = P.bg[2], bg = spec.diag.info },
        ["@markup"] = { fg = P.fg[2] },
        ["@markup.strong"] = { fg = P.red[1], style = "bold" },
        ["@markup.italic"] = { link = "Italic" },
        ["@markup.strikethrough"] = { fg = P.fg[2], style = "strikethrough" },
        ["@markup.underline"] = { link = "Underline" },
        ["@markup.heading"] = { link = "Title" },
        ["@markup.quote"] = { fg = P.fg[3] },
        ["@markup.math"] = { fg = syn.func },
        ["@markup.link"] = { fg = syn.keyword, style = "bold" },
        ["@markup.link.label"] = { link = "Special" },
        ["@markup.link.url"] = { fg = syn.const, style = "italic,underline" },
        ["@markup.raw"] = { fg = syn.ident, style = "italic" },
        ["@markup.raw.block"] = { fg = P.pink[1] },
        ["@markup.list"] = { fg = syn.builtin1, style = stl.operators },
        ["@markup.list.checked"] = { fg = P.green[1] },
        ["@markup.list.unchecked"] = { fg = P.yellow[1] },
        ["@diff.plus"] = { link = "diffAdded" },
        ["@diff.minus"] = { link = "diffRemoved" },
        ["@diff.delta"] = { link = "diffChanged" },
        ["@tag"] = { fg = syn.keyword },
        ["@tag.attribute"] = { fg = syn.func, style = "italic" },
        ["@tag.delimiter"] = { fg = syn.builtin1 },
        ["@label.json"] = { fg = syn.func },
        ["@constructor.lua"] = { fg = P.fg[3] },
        ["@field.rust"] = { fg = P.fg[3] },
        ["@variable.member.yaml"] = { fg = syn.func },

        ["@lsp.type.boolean"] = { link = "@boolean" },
        ["@lsp.type.builtinType"] = { link = "@type.builtin" },
        ["@lsp.type.comment"] = { link = "@comment" },
        ["@lsp.type.enum"] = { link = "@type" },
        ["@lsp.type.enumMember"] = { link = "@constant" },
        ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
        ["@lsp.type.formatSpecifier"] = { link = "@punctuation.special" },
        ["@lsp.type.interface"] = { fg = syn.builtin3 },
        ["@lsp.type.keyword"] = { link = "@keyword" },
        ["@lsp.type.namespace"] = { link = "@module" },
        ["@lsp.type.number"] = { link = "@number" },
        ["@lsp.type.operator"] = { link = "@operator" },
        ["@lsp.type.parameter"] = { link = "@parameter" },
        ["@lsp.type.property"] = { link = "@property" },
        ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
        ["@lsp.type.typeAlias"] = { link = "@type.definition" },
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
applyRecolTheme()
-- recol:end
