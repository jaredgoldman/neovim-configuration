local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local mappings = {
	n = {
		-- highlighting
		["<leader>nh"] = ":nohl<CR>",
		-- move between buffers
		["<c-h>"] = "<C-w>h",
		["<c-j>"] = "<C-w>j",
		["<c-k>"] = "<C-w>k",
		["<c-l>"] = "<C-w>l",
		-- open and close buggers
		["<leader>sv"] = "<C-w>s",
		["<leader>sh"] = "<C-w>v",
		["<leader>se"] = "<C-w>=",
		["<leader>sx"] = ":close<CR>",
		-- nvim-tree
		["<leader>e"] = ":NvimTreeFindFileToggle<CR>",
		["<leader>cf"] = ":NvimTreeCollapse<CR>",
		-- LSP
		["<leader>ls"] = ":lspstop<CR>",
		["<leader>lo"] = ":lspstart<CR>",
		-- Telescope
		["<leader>ff"] = "<cmd>Telescope find_files<CR>",
		["<leader>fw"] = "<cmd>Telescope live_grep<CR>",
		["<leader>fc"] = "<cmd>Telescope grep_string<CR>",
		["<leader>th"] = "<cmd>Themery<CR>",
		["<leader>sm"] = ":MaximizerToggle<CR>",
		-- FTerm
		["<leader>h"] = "<cmd>FTermToggle<CR>",
		-- Harpoon
		["<leader>a"] = "<cmd>HarpoonToggleFile<CR>",
		["<C-e>"] = "<cmd>HarpoonUI<CR>",
		["<leader>c"] = "<cmd>HarpoonClear<CR>",
		-- Formating
		["<leader>fm"] = "<cmd>Format<CR>",
		-- Disable help menu
		["<F1>"] = "<nop>",
	},
	x = {
		["<A-j>"] = ":move '>+1<CR>gv-gv",
		["<A-k>"] = ":move '<-2<CR>gv-gv",
	},
	i = {
		["<C-Space>"] = { 'copilot#Accept("<CR>")', expr = true },
		["<A-l>"] = "<esc>",
		["C-BS"] = "<cmd>HarpoonRemove<CR>",
		-- Disable help menu
		["<F1>"] = "<nop>",
	},
	t = {
		["C-h"] = "<C-\\><C-n>:FTermClose<CR>",
	},
}

for mode, mode_mappings in pairs(mappings) do
	for key, mapping in pairs(mode_mappings) do
		if type(mapping) == "function" then
			-- For direct Lua function calls; ensure your function returns a string command
			keymap(mode, key, "<cmd>lua " .. mapping() .. "<CR>", opts)
		elseif type(mapping) == "table" and mapping.expr then
			-- For expression mappings, like for copilot
			local expr_opts = vim.tbl_extend("force", opts, { expr = true })
			keymap(mode, key, mapping[1], expr_opts)
		elseif type(mapping) == "table" then
			-- For mappings that have their options specified directly
			keymap(mode, key, mapping[1], mapping[2] or opts)
		else
			-- For simple string command mappings
			keymap(mode, key, mapping, opts)
		end
	end
end
