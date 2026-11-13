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
opt.synmaxcol = 500  -- Syntax highlighting limit
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
    -- { "n",          "R",  ":source ~/.config/nvim/init.lua<CR>" },
    { "n",          "R",  ":restart<CR>" },
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
    -- { "n", "К", ":source ~/.config/nvim/init.lua<CR>" },
    { "n", "К", ":restart<CR>" },
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

-- if vim.fn.executable("rg") == 1 then
--     vim.api.nvim_create_user_command("Rg", function(opts)
--         if opts.args == "" then return end
--         local cmd = { "rg", "--vimgrep" }
--         vim.list_extend(cmd, vim.split(opts.args, "%s+"))
--         local results = vim.fn.systemlist(cmd)
--         if #results == 0 then return end
--         vim.fn.setqflist({}, " ", {
--             lines = results,
--             efm = "%f:%l:%c:%m",
--             title = "rg: " .. opts.args,
--         })
--         vim.cmd("copen")
--     end, { nargs = "*" })
--     vim.keymap.set("n", "<leader>g", ":Rg ")
-- end
--
-- if vim.fn.executable("fd") == 1 then
--     vim.api.nvim_create_user_command("Fd", function(opts)
--         if opts.args == "" then return end
--         local cmd = { "fd" }
--         vim.list_extend(cmd, vim.split(opts.args, "%s+"))
--         local results = vim.fn.systemlist(cmd)
--         if #results == 0 then return end
--         vim.fn.setloclist(0, {}, " ", {
--             lines = results,
--             efm = "%f",
--             title = "fd: " .. opts.args,
--         })
--         vim.cmd("lopen")
--     end, { nargs = "*", complete = "file" })
--     vim.keymap.set("n", "<leader>f", ":Fd ")
-- end

local ns = vim.api.nvim_create_namespace("edit_selection")

vim.keymap.set("x", "<leader>e", function()
    local src = vim.api.nvim_get_current_buf()
    if not vim.bo[src].modifiable then return end

    local mode = vim.fn.mode()
    local a, b = vim.fn.getpos("v"), vim.fn.getpos(".")
    if a[2] > b[2] or (a[2] == b[2] and a[3] > b[3]) then a, b = b, a end
    local sr, sc, er, ec = a[2] - 1, a[3] - 1, b[2] - 1, b[3] - 1

    local last = vim.api.nvim_buf_get_lines(src, er, er + 1, true)[1]
    if mode == "V" then
        sc, ec = 0, #last
    else
        ec = ec < #last and ec + 1 + vim.str_utf_end(last, ec + 1) or #last
    end

    vim.cmd("normal! \27")

    local text = vim.api.nvim_buf_get_text(src, sr, sc, er, ec, {})
    local id = vim.api.nvim_buf_set_extmark(src, ns, sr, sc, { end_row = er, end_col = ec })

    vim.cmd("split")
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, buf)
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].filetype = vim.bo[src].filetype
    vim.api.nvim_buf_set_lines(buf, 0, -1, true, text)

    vim.api.nvim_create_autocmd("BufUnload", {
        buffer = buf,
        once = true,
        callback = function()
            if not vim.api.nvim_buf_is_loaded(src) then return end
            local m = vim.api.nvim_buf_get_extmark_by_id(src, ns, id, { details = true })
            if #m == 0 then return end
            vim.api.nvim_buf_set_text(src, m[1], m[2], m[3].end_row, m[3].end_col,
                vim.api.nvim_buf_get_lines(buf, 0, -1, true))
            vim.api.nvim_buf_del_extmark(src, ns, id)
        end,
    })
end, { desc = "Edit selection in temp buffer" })

local function open_float(buf, title, size)
    local width = math.floor(vim.o.columns * size.width)
    local height = math.floor(vim.o.lines * size.height)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height - 3) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        border = "rounded",
        title = " " .. title .. " ",
        title_pos = "center",
    })
    vim.cmd.startinsert()
    return win
end

if vim.fn.executable("recol") == 1 then
    local function reload_config()
        local ok, err = pcall(vim.cmd.source, vim.fn.stdpath("config") .. "/init.lua")
        if not ok then
            vim.notify("Recol: config reload failed: " .. tostring(err), vim.log.levels.ERROR)
        end
    end
    local function launch_interactive_mode()
        local width = math.floor(vim.o.columns * 0.75)
        local height = math.floor(vim.o.lines * 0.75)
        local buf = vim.api.nvim_create_buf(false, true)
        local win = open_float(buf, "Recol", { width = 0.75, height = 0.75 })
        vim.bo[buf].bufhidden = "wipe"
        local job_id = vim.fn.termopen({ "recol", "-i", "--quit-on-select" }, {
            on_exit = function(_, code)
                vim.schedule(function()
                    if vim.api.nvim_win_is_valid(win) then
                        vim.api.nvim_win_close(win, true)
                    end
                    if code == 0 then
                        reload_config()
                    end
                end)
            end,
        })
        if job_id <= 0 then
            vim.notify("Recol: failed to start process", vim.log.levels.ERROR)
            vim.api.nvim_win_close(win, true)
            return
        end
        vim.cmd.startinsert()
    end
    vim.api.nvim_create_user_command("Recol", function(opts)
        local args = vim.split(opts.args, "%s+", { trimempty = true })
        if vim.tbl_contains(args, "-i") or vim.tbl_contains(args, "--interactive") then
            return launch_interactive_mode()
        end
        local cmd = vim.list_extend({ "recol" }, args)
        vim.system(cmd, { text = true }, function(res)
            vim.schedule(function()
                if res.code ~= 0 then
                    vim.notify("Recol: exit " .. res.code .. "\n" .. (res.stderr or ""), vim.log.levels.ERROR)
                end
                reload_config()
            end)
        end)
    end, { nargs = "*", desc = "Run recol (-i for interactive mode)" })
    vim.api.nvim_create_user_command("RecolOpen", launch_interactive_mode,
        { nargs = 0, desc = "Open recol interactively" })
end

if vim.fn.executable("pi") == 1 then
    vim.keymap.set("n", "<leader>af", function()
        local filepath = vim.api.nvim_buf_get_name(0)
        if filepath == "" then
            return
        end
        vim.cmd("update")
        if vim.fn.system({ "grep", "-q", "Pi:", filepath }) and vim.v.shell_error ~= 0 then
            vim.notify("No 'Pi:' instruction found", vim.log.levels.ERROR)
            return
        end
        vim.notify("Pi: applying instruction from " .. vim.fn.fnamemodify(filepath, ":t"), vim.log.levels.INFO)
        local prompt =
        [[Find the line starting with "Pi:" (possibly commented per this file's syntax). Apply it as an edit instruction, preserving existing style, then delete that line. Reply with one short line stating what changed, nothing else.]]
        vim.system({
            "pi",
            "@" .. filepath,
            "-p",
            prompt,
        }, {}, function(result)
            vim.schedule(function()
                if result.code == 0 then
                    vim.cmd("checktime")
                    vim.notify(result.stdout or "Done", vim.log.levels.INFO)
                else
                    vim.notify(
                        "Pi error: " .. (result.stderr or "Unknown error"),
                        vim.log.levels.ERROR
                    )
                end
            end)
        end)
    end)
    local pi_buf, pi_win
    vim.keymap.set("n", "<leader>ao", function()
        if pi_win and vim.api.nvim_win_is_valid(pi_win) then
            vim.api.nvim_win_close(pi_win, true)
            pi_win = nil
            return
        end
        if pi_buf and vim.api.nvim_buf_is_valid(pi_buf) then
            pi_win = open_float(pi_buf, "Pi", { width = 0.8, height = 0.75 })
            return
        end
        pi_buf = vim.api.nvim_create_buf(false, true)
        vim.bo[pi_buf].bufhidden = "hide"
        pi_win = open_float(pi_buf, "Pi", { width = 0.8, height = 0.75 })
        vim.fn.termopen("pi", {
            on_exit = function()
                pi_buf, pi_win = nil, nil
            end,
        })
    end, { desc = "Toggle Pi window" })
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

vim.pack.add({ "https://github.com/folke/snacks.nvim" })

if not vim.g.snacks_setup_done then
    require("snacks").setup({ picker = {} })
    vim.g.snacks_setup_done = true
end

vim.keymap.set("n", "<leader>f", function() Snacks.picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>g", function() Snacks.picker.grep() end, { desc = "Grep" })

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
    "c3",
    "csv",
    "go",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "json",
    "lua",
    "make",
    "markdown",
    "python",
    "rust",
    "toml",
    "proto",
    "sql",
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
    "emmet_ls",
    "pyright",
    "rust_analyzer",
    "gopls",
    "jsonls",
    "clangd",
    "sqlls",
    -- "c3_lsp",
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

if vim.fn.executable("c3_ls") == 1 then
    vim.filetype.add({
        extension = {
            c3 = "c3",
            c3i = "c3",
            c3t = "c3",
        },
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "c3",
        callback = function(args)
            vim.lsp.start({
                name = "c3_ls",
                cmd = { "c3_ls", "--stdlib-path", "/opt/homebrew/Cellar/c3c/0.8.4/lib/c3/std" },
                -- cmd = { "c3_ls" },
                root_dir = vim.fs.root(args.buf, { "project.json", ".git" }) or vim.fn.getcwd(),
                on_attach = function(_, bufnr)
                    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                end,
            }, { bufnr = args.buf })
        end,
    })
end

-- recol:start
-- Pharaoh's Voltage
local function applyRecolTheme()
    vim.cmd("highlight clear")
    if vim.fn.has("syntax_on") then vim.cmd("syntax reset") end
    local P = {
        black   = { "#475157", "#394146" },
        red     = { "#ea9166", "#ed9e78" },
        green   = { "#8bc49c", "#99cba8" },
        yellow  = { "#e9c366", "#ecca78" },
        blue    = { "#78b9e8", "#88c1eb" },
        magenta = { "#c79cda", "#cea8de" },
        cyan    = { "#74d5d6", "#85dadb" },
        white   = { "#e6d8b9", "#e9ddc6" },
        orange  = { "#eaaa66", "#edb478" },
        pink    = { "#d8a07a", "#ddaa8b" },
        bg      = { "#0d2431", "#102c3c", "#14374b", "#19435c", "#215b7c" },
        fg      = { "#fff0d0", "#f8e9ca", "#c0b49c", "#8f8775" },
        sel     = { "#344952", "#324445" },
        cur     = { "#ecca78", "#102c3c" },
        comment = "#9b9d91",
        diff    = {
            add = "#4e786c",
            del = "#7d5f51",
            change = "#447392",
            txt = "#59597b",
        }
    }
    for group, opts in pairs({
        Normal                                   = { bg = P.bg[2], fg = P.fg[2] },
        NormalNC                                 = "Normal",
        NormalFloat                              = { bg = P.bg[1], fg = P.fg[2] },
        FloatBorder                              = { bg = P.bg[1], fg = P.fg[4] },
        FloatTitle                               = { bg = P.bg[1], fg = P.blue[2], bold = true },
        FloatFooter                              = { bg = P.bg[1], fg = P.fg[4] },
        FloatShadow                              = { bg = P.black[1], blend = 80 },
        FloatShadowThrough                       = { bg = P.black[1], blend = 100 },
        Directory                                = { fg = P.blue[1] },
        EndOfBuffer                              = { fg = P.bg[2] },
        NonText                                  = { fg = P.comment },

        Cursor                                   = { bg = P.cur[1], fg = P.cur[2] },
        lCursor                                  = { bg = P.cyan[1], fg = P.cur[2] },
        CursorIM                                 = { bg = P.magenta[1], fg = P.cur[2] },
        TermCursor                               = { bg = P.cur[1], fg = P.cur[2] },
        CursorLine                               = { bg = P.bg[3] },
        CursorColumn                             = "CursorColumn",
        Visual                                   = { bg = P.sel[1] },
        VisualNOS                                = { bg = P.sel[2] },
        MatchParen                               = { fg = P.orange[1], bg = P.bg[4], bold = true },
        MCursor                                  = { bg = P.pink[1], fg = P.cur[2] },
        MCursorVisual                            = { bg = P.sel[2] },

        LineNr                                   = { fg = P.fg[4] },
        LineNrAbove                              = "LineNr",
        LineNrBelow                              = "LineNr",
        CursorLineNr                             = { fg = P.cur[1], bg = P.bg[3], bold = true },
        SignColumn                               = { bg = P.bg[2], fg = P.fg[4] },
        FoldColumn                               = { bg = P.bg[2], fg = P.fg[4] },
        CursorLineSign                           = { bg = P.bg[3] },
        CursorLineFold                           = { bg = P.bg[3], fg = P.fg[3] },

        WinSeparator                             = { fg = P.bg[5] },
        WinBar                                   = { fg = P.fg[2], bg = P.bg[2] },
        WinBarNC                                 = { fg = P.fg[4], bg = P.bg[1] },
        TabLine                                  = { fg = P.fg[3], bg = P.bg[3] },
        TabLineSel                               = { fg = P.cur[1], bg = P.bg[2], bold = true },
        TabLineFill                              = { bg = P.bg[1] },

        Search                                   = { bg = P.diff.txt, fg = P.fg[1] },
        CurSearch                                = { bg = P.yellow[1], fg = P.cur[2], bold = true },
        IncSearch                                = { bg = P.orange[1], fg = P.cur[2], bold = true },
        Substitute                               = { bg = P.red[1], fg = P.fg[1], bold = true },

        Pmenu                                    = { bg = P.bg[3], fg = P.fg[2] },
        PmenuSel                                 = { bg = P.bg[5], fg = P.fg[1], bold = true },
        PmenuMatch                               = { fg = P.blue[2], bold = true },
        PmenuMatchSel                            = { fg = P.yellow[2], bold = true },
        PmenuKind                                = { fg = P.magenta[1] },
        PmenuKindSel                             = { fg = P.magenta[2], bold = true },
        PmenuExtra                               = { fg = P.fg[4] },
        PmenuExtraSel                            = { fg = P.fg[3] },
        PmenuBorder                              = { bg = P.bg[3], fg = P.fg[4] },
        PmenuSbar                                = { bg = P.bg[4] },
        PmenuThumb                               = { bg = P.fg[4] },
        PmenuShadow                              = { bg = P.black[1], blend = 80 },
        PmenuShadowThrough                       = { bg = P.black[1], blend = 100 },
        ComplMatchIns                            = { fg = P.fg[3] },
        PreInsert                                = { fg = P.fg[3], bg = P.bg[4] },
        ComplHint                                = { fg = P.comment, italic = true },
        ComplHintMore                            = { fg = P.fg[4], italic = true },
        WildMenu                                 = { bg = P.bg[5], fg = P.fg[1], bold = true },
        SnippetTabstop                           = { bg = P.bg[4] },
        SnippetTabstopActive                     = { bg = P.diff.change, fg = P.fg[1] },

        SpellBad                                 = { undercurl = true, sp = P.red[1] },
        SpellCap                                 = { undercurl = true, sp = P.yellow[1] },
        SpellLocal                               = { underdotted = true, sp = P.cyan[1] },
        SpellRare                                = { underdotted = true, sp = P.magenta[1] },

        MsgArea                                  = { bg = P.bg[2], fg = P.fg[2] },
        MsgSeparator                             = { bg = P.bg[3], fg = P.bg[5] },
        OkMsg                                    = { fg = P.green[1] },
        Question                                 = { fg = P.blue[1], bold = true },
        MoreMsg                                  = { fg = P.cyan[1], bold = true },
        ModeMsg                                  = { fg = P.yellow[1], bold = true },
        WarningMsg                               = { fg = P.yellow[1] },
        ErrorMsg                                 = { fg = P.red[1], bold = true },
        StdoutMsg                                = { fg = P.fg[2] },
        StderrMsg                                = { fg = P.red[2] },

        DiffAdd                                  = { bg = P.diff.add },
        DiffChange                               = { bg = P.diff.change },
        DiffDelete                               = { bg = P.diff.del },
        DiffText                                 = { bg = P.diff.txt, bold = true },
        DiffTextAdd                              = { bg = P.diff.add, bold = true },

        Folded                                   = { bg = P.bg[3], fg = P.fg[3], italic = true },
        QuickFixLine                             = { bg = P.sel[2], fg = P.yellow[2], bold = true },

        StatusLine                               = { bg = P.bg[3], fg = P.fg[2] },
        StatusLineNC                             = { bg = P.bg[1], fg = P.fg[4] },
        StatusLineTerm                           = { bg = P.bg[3], fg = P.green[1] },
        StatusLineTermNC                         = { bg = P.bg[1], fg = P.fg[4] },
        StatusLineRemote                         = { bg = P.bg[3], fg = P.orange[1], bold = true },
        Title                                    = { fg = P.blue[1], bold = true },

        Menu                                     = { bg = P.bg[3], fg = P.fg[2] },
        Scrollbar                                = { bg = P.bg[3], fg = P.fg[4] },
        Tooltip                                  = { bg = P.bg[3], fg = P.fg[2] },

        ColorColumn                              = { bg = P.bg[3] },
        SpecialKey                               = { fg = P.cyan[1] },
        Whitespace                               = { fg = P.bg[5] },

        Comment                                  = { fg = P.comment },
        SpecialComment                           = { fg = P.cyan[2] },
        Constant                                 = { fg = P.orange[1] },
        String                                   = { fg = P.green[1] },
        Character                                = { fg = P.green[2] },
        Number                                   = "Constant",
        Float                                    = "Constant",
        Boolean                                  = "Constant",
        Regexp                                   = { fg = P.cyan[2] },
        Identifier                               = { fg = P.fg[2] },
        Function                                 = { fg = P.blue[1] },
        Statement                                = { fg = P.magenta[1] },
        Conditional                              = { fg = P.magenta[1] },
        Repeat                                   = { fg = P.magenta[1] },
        Label                                    = { fg = P.magenta[2] },
        Keyword                                  = { fg = P.magenta[1] },
        Exception                                = { fg = P.pink[1] },
        Operator                                 = { fg = P.fg[3] },
        PreProc                                  = { fg = P.pink[1] },
        Include                                  = { fg = P.red[1] },
        Define                                   = { fg = P.pink[1] },
        Macro                                    = { fg = P.pink[2] },
        PreCondit                                = { fg = P.pink[1] },
        Type                                     = { fg = P.yellow[1] },
        StorageClass                             = { fg = P.magenta[2] },
        Structure                                = { fg = P.yellow[1] },
        Typedef                                  = { fg = P.yellow[1] },
        Special                                  = { fg = P.cyan[1] },
        SpecialChar                              = { fg = P.yellow[2], bold = true },
        Tag                                      = { fg = P.blue[2] },
        Delimiter                                = { fg = P.fg[3] },
        Debug                                    = { fg = P.orange[1] },
        Underlined                               = { fg = P.blue[1], underline = true },
        Bold                                     = { bold = true },
        Italic                                   = { italic = true },
        BoldItalic                               = { bold = true, italic = true },
        Dimmed                                   = { fg = P.fg[4] },
        Ignore                                   = { fg = P.bg[2] },
        Error                                    = { fg = P.red[1] },
        Todo                                     = { bg = P.yellow[1], fg = P.black[1], bold = true },
        Added                                    = { fg = P.green[1] },
        Changed                                  = { fg = P.blue[1] },
        Removed                                  = { fg = P.red[1] },

        healthError                              = { fg = P.red[1] },
        healthSuccess                            = { fg = P.green[1] },
        healthWarning                            = { fg = P.yellow[1] },

        DiagnosticError                          = { fg = P.red[1] },
        DiagnosticWarn                           = { fg = P.yellow[1] },
        DiagnosticInfo                           = { fg = P.blue[1] },
        DiagnosticHint                           = { fg = P.cyan[1] },
        DiagnosticOk                             = { fg = P.green[1] },

        ["@variable"]                            = { fg = P.fg[2] },
        ["@variable.builtin"]                    = { fg = P.red[1] },
        ["@variable.parameter"]                  = { fg = P.fg[2] },
        ["@variable.parameter.builtin"]          = { fg = P.red[1] },
        ["@variable.member"]                     = { fg = P.blue[2] },
        ["@constant"]                            = "Constant",
        ["@constant.builtin"]                    = "Constant",
        ["@constant.macro"]                      = { fg = P.pink[2] },
        ["@module"]                              = { fg = P.cyan[2] },
        ["@module.builtin"]                      = { fg = P.cyan[1] },
        ["@label"]                               = { fg = P.magenta[2] },
        ["@string"]                              = { fg = P.green[1] },
        ["@string.documentation"]                = { fg = P.green[2] },
        ["@string.regexp"]                       = "Regexp",
        ["@string.escape"]                       = "SpecialChar",
        ["@string.special"]                      = "Special",
        ["@string.special.symbol"]               = { fg = P.magenta[1] },
        ["@string.special.url"]                  = { fg = P.blue[1], underline = true },
        ["@string.special.path"]                 = { fg = P.blue[2] },
        ["@character.special"]                   = { fg = P.cyan[2] },
        ["@character"]                           = "Character",
        ["@boolean"]                             = "Boolean",
        ["@number"]                              = "Number",
        ["@number.float"]                        = "Float",
        ["@type"]                                = "Type",
        ["@type.builtin"]                        = { fg = P.cyan[2] },
        ["@type.definition"]                     = "Typedef",
        ["@attribute"]                           = { fg = P.pink[2] },
        ["@attribute.builtin"]                   = { fg = P.pink[1] },
        ["@property"]                            = { fg = P.blue[2] },
        ["@function"]                            = "Function",
        ["@function.builtin"]                    = { fg = P.red[1] },
        ["@function.call"]                       = "Function",
        ["@function.macro"]                      = { fg = P.red[1] },
        ["@function.method"]                     = "Function",
        ["@function.method.call"]                = "Function",
        ["@constructor"]                         = { fg = P.cyan[1] },
        ["@operator"]                            = "Operator",

        ["@keyword"]                             = "Keyword",
        ["@keyword.coroutine"]                   = "Keyword",
        ["@keyword.function"]                    = "Keyword",
        ["@keyword.operator"]                    = "Operator",
        ["@keyword.import"]                      = "Include",
        ["@keyword.type"]                        = "Keyword",
        ["@keyword.modifier"]                    = "Keyword",
        ["@keyword.repeat"]                      = "Repeat",
        ["@keyword.return"]                      = { fg = P.red[1] },
        ["@keyword.debug"]                       = "Debug",
        ["@keyword.exception"]                   = "Exception",
        ["@keyword.conditional"]                 = "Conditional",
        ["@keyword.conditional.ternary"]         = { fg = P.cyan[1] },
        ["@keyword.directive"]                   = "PreProc",
        ["@keyword.directive.define"]            = "Define",

        ["@punctuation.delimiter"]               = "Delimiter",
        ["@punctuation.bracket"]                 = { fg = P.fg[3] },
        ["@punctuation.special"]                 = { fg = P.cyan[2] },

        ["@comment"]                             = "Comment",
        ["@comment.documentation"]               = { fg = P.comment },
        ["@comment.error"]                       = { bg = P.red[1], fg = P.black[1], bold = true },
        ["@comment.warning"]                     = { bg = P.yellow[1], fg = P.black[1], bold = true },
        ["@comment.todo"]                        = "Todo",
        ["@comment.note"]                        = { bg = P.blue[1], fg = P.black[1], bold = true },

        ["@markup.strong"]                       = { fg = P.red[1], bold = true },
        ["@markup.italic"]                       = { italic = true },
        ["@markup.strikethrough"]                = { strikethrough = true },
        ["@markup.underline"]                    = { underline = true },
        ["@markup.heading"]                      = { fg = P.blue[1], bold = true },
        ["@markup.quote"]                        = { fg = P.fg[3] },
        ["@markup.math"]                         = { fg = P.cyan[2] },
        ["@markup.link"]                         = { fg = P.magenta[1] },
        ["@markup.link.label"]                   = { fg = P.blue[2] },
        ["@markup.link.url"]                     = { fg = P.magenta[2], underline = true },
        ["@markup.raw"]                          = { fg = P.green[2], bg = P.bg[3] },
        ["@markup.raw.block"]                    = { fg = P.fg[2] },
        ["@markup.list"]                         = { fg = P.cyan[2] },
        ["@markup.list.checked"]                 = { fg = P.green[1] },
        ["@markup.list.unchecked"]               = { fg = P.fg[4] },

        ["@diff.plus"]                           = { fg = P.green[1] },
        ["@diff.minus"]                          = { fg = P.red[1] },
        ["@diff.delta"]                          = { fg = P.blue[1] },
        ["@tag"]                                 = { fg = P.red[1] },
        ["@tag.builtin"]                         = { fg = P.red[1] },
        ["@tag.attribute"]                       = { fg = P.orange[2] },
        ["@tag.delimiter"]                       = { fg = P.fg[3] },

        ["@constructor.lua"]                     = { fg = P.fg[3] },
        ["@field.rust"]                          = { fg = P.fg[3] },
        ["@label.json"]                          = "@property",
        ["@variable.member.yaml"]                = "@property",

        ["@lsp.type.comment"]                    = {},
        ["@lsp.type.keyword"]                    = {},
        ["@lsp.type.modifier"]                   = {},
        ["@lsp.type.number"]                     = {},
        ["@lsp.type.operator"]                   = {},
        ["@lsp.type.regexp"]                     = {},
        ["@lsp.type.string"]                     = {},
        ["@lsp.type.variable"]                   = {},
        ["@lsp.type.namespace.go"]               = {},

        ["@lsp.type.interface"]                  = { fg = P.red[1] },
        ["@lsp.type.boolean"]                    = "@boolean",
        ["@lsp.type.builtinConstant"]            = "@constant.builtin",
        ["@lsp.type.generic"]                    = "@type",
        ["@lsp.type.builtinType"]                = "@type.builtin",
        ["@lsp.type.enum"]                       = "@type",
        ["@lsp.type.enumMember"]                 = "@constant",
        ["@lsp.type.escapeSequence"]             = "@string.escape",
        ["@lsp.type.formatSpecifier"]            = "@punctuation.special",
        ["@lsp.type.namespace"]                  = "@module",
        ["@lsp.type.parameter"]                  = "@parameter",
        ["@lsp.type.property"]                   = "@property",
        ["@lsp.type.selfKeyword"]                = "@variable.builtin",
        ["@lsp.type.typeAlias"]                  = "@type.definition",
        ["@lsp.type.unresolvedReference"]        = "@error",
        ["@lsp.typemod.function.defaultLibrary"] = "@function.builtin",
        ["@lsp.typemod.function.builtin"]        = "@function.builtin",

        ["@lsp.type.selfParameter.python"]       = "@variable.builtin",
        ["@lsp.type.clsParameter.python"]        = "@variable.builtin",

        ["@lsp.type.table.toml"]                 = "@property",
        ["@lsp.type.key.toml"]                   = "@property",
        ["@lsp.type.boolean.toml"]               = "Boolean",
        ["@lsp.type.offsetDateTime.toml"]        = "Special",
        ["@lsp.type.localDateTime.toml"]         = "Special",
        ["@lsp.type.localDate.toml"]             = "Special",
        ["@lsp.type.localTime.toml"]             = "Special",
    }) do
        if type(opts) == "string" then
            opts = { link = opts }
        end
        vim.api.nvim_set_hl(0, group, opts)
    end
end
applyRecolTheme()
-- recol:end
