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
vim.opt.guicursor = "n-v-i-c:block-Cursor"

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
vim.keymap.set("n", "<leader>u", ":source ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>o", ":copen<CR>")
vim.keymap.set("n", "<leader>c", ":cclose<CR>")
vim.keymap.set("n", "<leader>t", ":tabnew | terminal<CR>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.keymap.set("t", "<esc><esc>", "<C-\\><C-n>", { buffer = true })
    end,
})

if vim.fn.executable("rg") then
    vim.api.nvim_create_user_command("Rg", function(opts)
        if opts.args == "" then return end
        local results = vim.fn.systemlist("rg --vimgrep " .. opts.args)
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_err_writeln("Rg error: " .. table.concat(results, "\n"))
            return
        end
        if #results == 0 then return end
        vim.fn.setqflist({}, " ", {
            items = vim.fn.getqflist({ lines = results, efm = "%f:%l:%c:%m" }).items,
            title = "Rg: " .. opts.args,
        })
        vim.cmd("copen")
    end, { nargs = "*", complete = "file" })
    vim.keymap.set("n", "<leader>g", ":Rg ", { noremap = true, silent = false })
end
if vim.fn.executable("fd") then
    vim.api.nvim_create_user_command("Fd", function(opts)
        if opts.args == "" then return end
        local results = vim.fn.systemlist("fd " .. opts.args)
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_err_writeln("Fg error: " .. table.concat(results, "\n"))
            return
        end
        if #results == 0 then return end
        local formatted = {}
        for _, line in ipairs(results) do
            formatted[#formatted + 1] = line .. ":1"
        end
        vim.fn.setqflist({}, " ", {
            items = vim.fn.getqflist({ lines = formatted, efm = "%f:%l" }).items,
            title = "Fd: " .. opts.args,
        })
        vim.cmd("copen")
    end, { nargs = "*", complete = "file" })
    vim.keymap.set("n", "<leader>f", ":Fd ", { noremap = true, silent = false })
end

local themes = {
    nightfox = function(opt)
        vim.pack.add({ "https://github.com/EdenEast/nightfox.nvim" })
        require("nightfox").setup(opt)
        vim.cmd("colorscheme terafox")
    end,

}

-- themes.gruber()

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
    "vtsls",
    "pyright",
    "rust_analyzer",
    "gopls",
    "jsonls",
    "clangd",
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
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        signature = { enabled = true },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            menu = {
                auto_show = true,
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

-- [STARTRECOLMARK]

-- Apple System Colors Light

local function applyRecol()
    vim.cmd("highlight clear")
    if vim.fn.has("syntax_on") then vim.cmd("syntax reset") end

    local P = {
        black   = { "#1a1a1a", "#1a1a1a", "#161616" },
        red     = { "#cc372e", "#cc372e", "#ad2f27" },
        green   = { "#26a439", "#26a439", "#208b30" },
        yellow  = { "#cdac08", "#cdac08", "#ae9207" },
        blue    = { "#0869cb", "#0869cb", "#0759ad" },
        magenta = { "#9647bf", "#9647bf", "#803ca2" },
        cyan    = { "#479ec2", "#479ec2", "#3c86a5" },
        white   = { "#98989d", "#98989d", "#818185" },
        orange  = { "#cd721b", "#cd721b", "#ae6017" },
        pink    = { "#b26866", "#b26866", "#975856" },
        bg = { "#f3f4f4", "#feffff", "#eff0f0", "#e0e0e0", "#c4c4c4" },
        fg = { "#0f0f0f", "#000000", "#3b3b3b", "#707070" },
        sel = { "#d8d9d9", "#e6e6e7" },
        cur = { 
            bg = "#98989d",
            fg = "#ffffff",
        },
        comment = "#666666",
        status_line = "#f3f4f4",
        diff = {
            add = "#51b661",
            delete = "#d65f58",
            change = "#3987d5",
            text = "#b57ed2",
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
        builtin1    = P.cyan[3],
        builtin2    = P.orange[3],
        builtin3    = P.red[3],
        comment     = P.comment,
        conditional = P.magenta[3],
        const       = P.orange[3],
        dep         = P.fg[4],
        field       = P.blue[1],
        func        = P.blue[3],
        ident       = P.cyan[1],
        keyword     = P.magenta[1],
        number      = P.orange[1],
        operator    = P.fg[3],
        preproc     = P.pink[3],
        regex       = P.yellow[3],
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
        VisualNOS    = inv.visual and { style = "reverse" } or { link = "visual" },
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
        qfLineNr       = { link = "lineNr" },
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
applyRecol()

-- [ENDRECOLMARK]
