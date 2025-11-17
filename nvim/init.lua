vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.hidden = true
vim.opt.swapfile = false
vim.opt.encoding = "UTF-8"
vim.opt.autoread = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.scrolloff = 6
vim.opt.sidescrolloff = 4
vim.opt.mouse = "a"
vim.opt.wildmenu = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.belloff = "all"
vim.opt.winborder = "rounded"
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1

vim.g.mapleader = " "
vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>e", ":edit .<CR>")
vim.keymap.set("n", "<leader>r", ":edit #<CR>")
vim.keymap.set("n", "<leader>t", ":tabnew | terminal<CR>")
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format entire buffer" })
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { buffer = true })
    end,
})

local themes = {
    vague = function(opt)
        vim.pack.add({ "https://github.com/vague-theme/vague.nvim" })
        require("vague").setup(opt)
        vim.cmd("colorscheme vague")
    end,
    gruvbox = function(opt)
        vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })
        require("gruvbox").setup(opt)
        vim.cmd("colorscheme gruvbox")
    end,
    black_metal = function(opt)
        vim.pack.add({ "https://github.com/metalelf0/black-metal-theme-neovim" })
        require("black-metal").setup(opt)
        require("black-metal").load()
    end
}

function SetMyTheme()
    vim.cmd("highlight clear")
    vim.cmd("syntax reset")

    vim.g.colors_name = "mytheme"
    vim.opt.termguicolors = true

    local c = {
        void = "#000000",
        bg1 = "#0A0908",
        bg2 = "#1D1B18",
        bg3 = "#302D28",
        visual = "#201E1A",
        cursor = "#F0F7FA",
        fg01 = "#DCE9FB",
        fg = "#d2d1d0",
        fg1 = "#A6A4A2",
        fg2 = "#7A7775",
        fg3 = "#494949",
        sline = "#4C4B49",
        string = "#66A0A7",
        keyword = "#A94646",
        func = "#8E8EB4",
        ttype = "#c7c1a9",
        const = "#86A1CF",
        red = "#9E4941",
        green = "#2E6259",
        yellow = "#dfb659",
        blue = "#748cab",
        violet = "#61587A",
        pink = "#BA86A4",
        redbg = "#391A17",
        greenbg = "#102320",
        yellowbg = "#5E4712",
        bluebg = "#273240",
        violetbg = "#23202C",
        pinkbg = "#492A3C",
        i = "#FF00FF",
    }

    local hi = function(name, val)
        vim.api.nvim_set_hl(0, name, val)
    end

    hi("Normal", { fg = c.fg, bg = c.void })
    hi("StatusLine", { fg = c.fg, bg = c.sline })
    hi("StatusLineNC", { fg = c.fg2, bg = c.bg2 })
    hi("MatchParen", { fg = c.fg01, bg = c.bg3, bold = true })
    hi("Visual", { bg = c.visual })
    hi("Cursor", { fg = c.void, bg = c.cursor })
    hi("LineNr", { fg = c.fg3 })
    hi("CursorLine", { bg = c.bg1 })
    hi("CursorLineNr", { fg = c.fg1, bg = c.bg1, bold = true })
    hi("TermCursor", { fg = c.cursor })
    hi("Search", { bg = c.bg2, fg = c.fg, bold = true })
    hi("CurSearch", { bg = c.bg2, fg = c.fg01, bold = true })
    hi("IncSearch", { bg = c.bg3, fg = c.fg01, bold = true })
    hi("Directory", { fg = c.fg1 })
    hi("Title", { fg = c.string })

    hi("VertSplit", { fg = c.bg2 })
    hi("WinSeparator", { link = "VertSplit" })

    hi("lCursor", { fg = c.bg1, bg = c.bg3 })
    hi("CursorColumn", { bg = c.bg2 })
    hi("CursorLineSign", { link = "CursorLine" })
    hi("VisualNOS", { fg = c.fg, bg = c.bg1 })
    hi("VisualNonText", { fg = c.fg3, bg = c.bg1 })

    hi("ColorColumn", { bg = c.bg1 })
    hi("Folded", { fg = c.fg1, bg = c.bg1 })
    hi("FoldColumn", { fg = c.fg3, bg = c.void })
    hi("SignColumn", { fg = c.fg3, bg = c.void })

    hi("ModeMsg", { fg = c.green })
    hi("MoreMsg", { fg = c.yellow })
    hi("Question", { fg = c.blue })
    hi("MsgArea", { fg = c.fg1 })

    hi("Boolean", { fg = c.const })
    hi("Comment", { fg = c.fg2, italic = true })
    hi("Constant", { fg = c.const, bold = true })
    hi("Number", { link = "Constant" })
    hi("String", { fg = c.string })
    hi("Delimiter", { fg = c.fg1 })
    hi("Identifier", { fg = c.fg1 })
    hi("Function", { fg = c.func })
    hi("StorageClass", { fg = c.keyword, bold = true })
    hi("Label", { fg = c.fg })
    hi("NonText", { fg = c.fg })
    hi("Repeat", { fg = c.keyword, bold = true })
    hi("PreProc", { fg = c.fg })
    hi("Type", { fg = c.ttype })
    hi("Special", { fg = c.fg1, italic = true })
    hi("Operator", { fg = c.fg })
    hi("Structure", { fg = c.keyword, bold = true })
    hi("Statement", { fg = c.keyword })
    hi("Whitespace", { fg = c.bg3 })

    hi("Error", { fg = c.red, bg = c.void })
    hi("ErrorMsg", { fg = c.red, bg = c.void })
    hi("WarningMsg", { fg = c.yellow, bg = c.void })

    hi("NormalFloat", { fg = c.fg, bg = c.bg1 })
    hi("FloatBorder", { fg = c.fg2, bg = c.bg1 })
    hi("FloatTitle", { fg = c.fg, bold = true })
    hi("ComplHint", { fg = c.fg3 })
    hi("ComplHintMore", { fg = c.fg1 })
    hi("ComplMatchIns", { fg = c.fg01 })
    hi("Pmenu", { fg = c.fg, bg = c.bg1 })
    hi("PmenuBorder", { fg = c.fg2, bg = c.bg1 })
    hi("PmenuSel", { fg = c.fg, bg = c.bg2, bold = true })
    hi("PmenuSbar", { bg = c.bg1 })
    hi("PmenuThumb", { bg = c.fg3 })
    hi("WildMenu", { fg = c.fg, bg = c.bg1 })

    hi("SpellBad", { sp = c.red, underline = true })
    hi("SpellCap", { sp = c.pink, underline = true })
    hi("SpellRare", { sp = c.violet, underline = true })
    hi("SpellLocal", { sp = c.violet, underline = true })

    hi("Todo", { fg = c.blue })
    hi("Ignore", { fg = c.fg2 })
    hi("QuickFixLine", { link = "CursorLine" })
    hi("qfFileName", { fg = c.blue })
    hi("Conceal", { fg = c.fg3 })

    hi("DiffAdd", { bg = c.greenbg })
    hi("DiffChange", { bg = c.yellowbg })
    hi("DiffDelete", { bg = c.redbg })
    hi("DiffText", { bg = c.violetbg })

    hi("GitSignsAdd", { fg = c.green })
    hi("GitSignsChange", { fg = c.yellow })
    hi("GitSignsDelete", { fg = c.red })

    hi("DiagnosticError", { fg = c.red })
    hi("DiagnosticWarn", { fg = c.yellow })
    hi("DiagnosticInfo", { fg = c.blue })
    hi("DiagnosticHint", { fg = c.violet })

    hi("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
    hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
    hi("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
    hi("DiagnosticUnderlineHint", { undercurl = true, sp = c.violet })
    hi("DiagnosticOk", { fg = c.green })

    hi("WinBar", { fg = c.fg2, bg = c.bg2 })
    hi("WinBarNC", { fg = c.fg3, bg = c.bg1 })
    hi("TabLine", { fg = c.fg2, bg = c.bg1 })
    hi("TabLineSel", { fg = c.fg, bg = c.sline, bold = true })

    hi("EndOfBuffer", { fg = c.bg3 })

    hi("healthSuccess", { link = "DiffAdd" })
    hi("healthHeadingChar", { fg = c.fg })
    hi("helpHeader", { fg = c.fg })

    hi("@comment.error", { fg = c.red })
    hi("@comment.note", { fg = c.violet })
    hi("@comment.ok", { fg = c.green })
    hi("@comment.todo", { fg = c.blue })
    hi("@comment.warning", { fg = c.yellow })

    hi("@attribute", { fg = c.fg })
    hi("@variable", { fg = c.fg })
    hi("@function", { link = "Function" })
    hi("@method", { link = "Function" })
    hi("@function.macro", { link = "Function" })
    hi("@keyword", { fg = c.keyword, bold = true })
    hi("@keyword.import", { fg = c.keyword, bold = true })
    hi("@keyword.storage", { fg = c.keyword, bold = true })
    hi("@string", { link = "String" })
    hi("@comment", { link = "Comment" })

    hi("@field", { fg = c.fg })
    hi("@property", { fg = c.fg })
    hi("@parameter", { fg = c.fg1 })
    hi("@type.builtin", { fg = c.ttype })
    hi("@constant", { fg = c.const })
    hi("@number", { fg = c.const, bold = true })
    hi("@boolean", { link = "Boolean" })
    hi("@operator", { fg = c.fg })

    hi("@markup.underline", { underline = true })
end

SetMyTheme()

-- themes.vague( { colors = { bg = "#000000" } } )

local treesitter_ensure_installed = {
    "c",
    "go",
    "lua",
    "vim",
    "json",
    "make",
    "bash",
    "rust",
    "query",
    "vimdoc",
    "python",
    "markdown",
    "javascript",
    "markdown_inline",
}

local lspservers_ensure_installed = {
    "lua_ls",
    "html",
    "eslint",
    "pyright",
    "rust_analyzer",
    "gopls"
}

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
            vim.cmd("TSUpdate")
        end
    end
})

if #treesitter_ensure_installed > 0 then
    vim.pack.add({
        { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" }
    })
    require("nvim-treesitter.configs").setup({
        ensure_installed = treesitter_ensure_installed,
        highlight = {
            enable = true,
            disable = function(_, buf)
                local max_filesize = 255 * 1024
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        autotag = { enable = true },
        auto_install = false,
    })
end

if #lspservers_ensure_installed > 0 then
    vim.pack.add({
        "https://github.com/neovim/nvim-lspconfig",
        "https://github.com/mason-org/mason.nvim",
        "https://github.com/mason-org/mason-lspconfig.nvim",
        "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
        "https://github.com/rafamadriz/friendly-snippets",
        "https://github.com/saghen/blink.cmp",
    })

    require("mason").setup()
    require("mason-tool-installer").setup({
        ensure_installed = lspservers_ensure_installed,
    })
    require("mason-lspconfig").setup({
        ensure_installed = lspservers_ensure_installed,
        automatic_enable = true,
    })

    vim.diagnostic.config({
        virtual_text = true,
        virtual_lines = false,
        update_in_insert = false,
    })

    require("blink.cmp").setup({
        keymap = {
            preset = "default",
            ["<C-space>"] = {},
            ["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
        },
        signature = { enabled = true },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            menu = {
                auto_show = true,
                auto_show_delay_ms = 900,
                draw = {
                    treesitter = { "lsp" },
                    columns = {
                        { "kind_icon", "label", "label_description", gap = 1 },
                        { "kind" }
                    },
                },
            },
        },
        fuzzy = { implementation = "lua" },
    })
end

local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
    vim.fn.mkdir(undodir, "p")
end
