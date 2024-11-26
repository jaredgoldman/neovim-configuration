---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
  tabufline = {
    enabled = false,
  },
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

-- M.options = require "custom.options"
local opt = vim.opt
local api = vim.api
-- line numbers
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.cindent = true
opt.softtabstop = 4

-- lne wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- backspace
opt.backspace = "indent,eol,start"

-- autoread
opt.autoread = true
-- Function to set autocmd
local function set_autocmd(event, pattern, command)
  vim.cmd(string.format("autocmd %s %s %s", event, pattern, command))
end

-- Trigger 'checktime' on 'CursorHold' event
set_autocmd("CursorHold", "*", "checktime")

-- Show trailing whitespace
api.nvim_set_option("list", true)
api.nvim_set_option("listchars", "eol:$,nbsp:_,tab:>-,trail:~,extends:>,precedes:<")

-- remove whitespace on save
api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[if &filetype !~# 'lsp' | %s/\s\+$//e | endif]],
})

return M
