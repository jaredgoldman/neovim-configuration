local opt = vim.opt
local api = vim.api
local global = vim.g

-- Hint: use `:h <option>` to figure out the meaning if needed
opt.clipboard = "unnamedplus" -- use system clipboard
opt.completeopt = { "menu", "menuone", "noselect" }
opt.mouse = "a"               -- allow the mouse to be used in Nvim

-- General
opt.wrap = false
global.loaded_netrw = 1
global.loaded_netrwPlugin = 1
global.mapleader = " "

-- Navigation
opt.cursorline = true
opt.backspace = "indent,eol,start"

-- Tab
opt.tabstop = 4      -- number of visual spaces per TAB
opt.softtabstop = 4  -- number of spacesin tab when editing
opt.shiftwidth = 4   -- insert 4 spaces on a tab
opt.expandtab = true -- tabs are spaces, mainly because of python

-- UI config
opt.number = true        -- show absolute number
-- opt.relativenumber = true -- add numbers to each line on the left side
opt.cursorline = true    -- highlight cursor line underneath the cursor horizontally
opt.splitbelow = true    -- open new vertical split bottom
opt.splitright = true    -- open new horizontal splits right
opt.termguicolors = true -- enabl 24-bit RGB color in the TUI

-- Searching
opt.incsearch = true  -- search as characters are entered
opt.hlsearch = false  -- do not highlight matches
opt.ignorecase = true -- ignore case in searches by default
opt.smartcase = true  -- but make it case sensitive if an uppercase is entered

-- History
opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"

-- Whitespace
api.nvim_set_option("list", true)
api.nvim_set_option("listchars", "eol:$,nbsp:_,tab:>-,trail:~,extends:>,precedes:<")
api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[if &filetype !~# 'lsp' | %s/\s\+$//e | endif]],
})

