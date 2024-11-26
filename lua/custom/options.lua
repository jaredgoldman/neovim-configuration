local opt = vim.opt
local api = vim.api
-- line numbers
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.softtabstop = 2

-- lne wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- backspace
opt.backspace = "indent,eol,start"

-- Show trailing whitespace
api.nvim_set_option("list", true)
api.nvim_set_option("listchars", "eol:$,nbsp:_,tab:>-,trail:~,extends:>,precedes:<")

-- remove whitespace on save
api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[if &filetype !~# 'lsp' | %s/\s\+$//e | endif]],
})
