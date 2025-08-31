-- Neovim for Mobile
-- https://github.com/Cyan903/dot

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- No plugins are installed, for future use.
vim.g.have_nerd_font = true

-- Autocommands {{{
--- Highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

--- Enable folds
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("fold-filetype", { clear = true }),
    pattern = { "vim", "lua" },
    callback = function()
        vim.opt_local.foldmethod = "marker"
    end,
})
-- }}}

-- Keymaps {{{
--- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

--- Diagnostic keymaps
vim.keymap.set("n", "<leader>qd", vim.diagnostic.setloclist, { desc = "[Q]uickfix [D]iagnostic list" })

--- Quickfix keymaps
vim.keymap.set("n", "<leader>qq", function()
    local qf_exists = false

    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end

    if qf_exists then
        vim.cmd("cclose")
        return
    end

    if not vim.tbl_isempty(vim.fn.getqflist()) then
        vim.cmd("copen")
    end
end, { desc = "[Q]uickfix toggle" })

vim.cmd([[
    nnoremap <M-j> <cmd>cnext<cr>
    nnoremap <M-k> <cmd>cprev<cr>
]])

--- Delete word with CTRL + Backspace
vim.keymap.set("i", "<C-backspace>", "<C-w>")

--- Better split navigation keymaps
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

--- Terminal keymaps
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" }) -- default is <C-\><C-n>

--- Split keymaps
vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-]>", "<C-W>+")
vim.keymap.set("n", "<M-[>", "<C-W>-")
-- }}}

-- Options {{{
--- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

--- Allow mouse & hide mode
vim.opt.mouse = "a"
vim.opt.showmode = false

--- Schedule the setting after UiEnter because it can increase startup-time.
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

--- Use ripgrep over grep
if vim.fn.executable("rg") == 1 then
    vim.opt.grepprg = "rg --vimgrep"
end

--- Save undo history
vim.opt.undofile = true

--- Case-insensitive searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

--- Show sign column for git
vim.opt.signcolumn = "yes"

--- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300 -- Displays which-key popup sooner

--- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

--- Display whitespace
vim.opt.list = true
vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
}

--- Preview substitutions
vim.opt.inccommand = "split"
vim.opt.cursorline = true

--- Max scroll distance
vim.opt.scrolloff = 10

--- Word wrapping
vim.opt.breakindent = false
vim.opt.linebreak = false
vim.opt.wrap = false

--- Tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

--- Set command height
vim.opt.cmdheight = 1

--- Enable terminal colors
vim.opt.termguicolors = true

--- Tree style for netrw
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3

--- Abbreviations
vim.cmd("cabbrev W w")
vim.cmd("cabbrev WQ wq")
-- }}}

-- Usercommands {{{
--- Toggle word wrapping and remap jk
vim.api.nvim_create_user_command("WordWrapToggle", function()
    vim.cmd([[
        set wrap!

        if &wrap
            noremap j gj
            noremap k gk
            set norelativenumber
        else
            unmap j
            unmap k
            set relativenumber
        endif
    ]])
end, { desc = "Toggle word wrapping on a file" })
-- }}}

-- Theme {{{
vim.cmd("syntax on")
vim.cmd("colorscheme lunaperche")
-- }}}

