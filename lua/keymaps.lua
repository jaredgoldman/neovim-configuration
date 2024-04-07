local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local mappings = {
    n = {
        ["<leader>nh"] = ":nohl<CR>",
        ["<leader>sv"] = "<C-w>s",
        ["<leader>sh"] = "<C-w>v",
        ["<leader>se"] = "<C-w>=",
        ["<leader>sx"] = ":close<CR>",
        -- nvim-tree
        ["<leader>e"]  = ":NvimTreeToggle<CR>",
        ["<leader>cf"] = ":NvimTreeCollapse<CR>",
        -- lsp
        ["<leader>ls"] = ":lspstop<CR>",
        ["<leader>lo"] = ":lspstart<CR>",
        -- move between buffers
        ["<c-h>"]      = "<C-w>h",
        ["<c-j>"]      = "<C-w>j",
        ["<c-k>"]      = "<C-w>k",
        ["<c-l>"]      = "<C-w>l",
        ["<leader>ff"] = "<cmd>Telescope find_files<CR>",
        ["<leader>fw"] = "<cmd>Telescope live_grep<CR>",
        ["<leader>fc"] = "<cmd>Telescope grep_string<CR>",
        ["<leader>th"] = "<cmd>Themery<CR>",
        ["<leader>sm"] = ":MaximizerToggle<CR>"
    },
    x = {
        ["J"] = ":move '>+1<CR>gv-gv",
        ["K"] = ":move '<-2<CR>gv-gv",
        ["<A-j>"] = ":move '>+1<CR>gv-gv",
        ["<A-k>"] = ":move '<-2<CR>gv-gv",
    },
    i = {
        ["c-j"] = [[<cmd>lua require('copilot').accept()<CR>]],
        ["<m-l>"] = "<esc>",
    },
}

for mode, mode_mappings in pairs(mappings) do
    for key, mapping in pairs(mode_mappings) do
        if type(mapping) == "function" then
            keymap(mode, key, "<cmd>lua " .. mapping() .. "<>", opts)
        elseif type(mapping) == "table" then
            keymap(mode, key, mapping[1], mapping[2] or opts)
        else
            keymap(mode, key, mapping, opts)
        end
    end
end
