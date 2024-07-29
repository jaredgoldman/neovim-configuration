---@type MappingsTable
--
local M = {}

local opts = { noremap = true, silent = true }

M.general = {
  n = {
    ["<leader>nh"] = { ":nohl<CR>", "nohl", opts },
    ["<leader>sv"] = { "<C-w>s", "split window vertically", opts },
    ["<leader>sh"] = { "<C-w>v", "split window horizontally", opts },
    ["<leader>se"] = { "<C-w>=", "make split windows even width", opts },
    ["<leader>sx"] = { ":close<CR>", "close current split window", opts },
    ["<leader>tx"] = { ":tabclose<CR>", "close current tab", opts },
    ["<leader>e"] = { ":NvimTreeToggle<CR>", "nvim-tree", opts },
    ["<leader>ls"] = { ":LspStop<CR>", "LSP", opts },
    ["<leader>lo"] = { ":LspStart<CR>", "LSP", opts },
    ["<leader>cf"] = { ":NvimTreeCollapse<CR>", "nvim-tree", opts },
  },

  x = {
    ["J"] = { ":move '>+1<CR>gv-gv", "Move text up", opts },
    ["K"] = { ":move '<-2<CR>gv-gv", "Move text down", opts },
    ["<A-j>"] = { ":move '>+1<CR>gv-gv", "Move text up", opts },
    ["<A-k>"] = { ":move '<-2<CR>gv-gv", "Move text down", opts },
  },

  i = {
    ["C-j"] = { 'copilot#Accept("<CR>")', "Copilot accept", { silent = true, expr = true } },
    ["<M-l>"] = { "<ESC>", "escape", opts },
  },
}

return M
