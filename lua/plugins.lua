local dashboard = require("config.dashboard")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Dashboard
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = dashboard.dashboard_config,
	},
	-- Theming
	-- "tanvirtin/monokai.nvim",
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
	},
	"yorickpeterse/nvim-grey",
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"onsails/lspkind.nvim",
		event = { "VimEnter" },
	},
	-- Auto-completion engine
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "lspkind.nvim" },
		config = function()
			require("config.nvim-cmp")
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp", dependencies = { "nvim-cmp" } },
	{ "hrsh7th/cmp-buffer", dependencies = { "nvim-cmp" } }, -- buffer auto-completion
	{ "hrsh7th/cmp-path", dependencies = { "nvim-cmp" } }, -- path auto-completion
	{ "hrsh7th/cmp-cmdline", dependencies = { "nvim-cmp" } }, -- cmdline auto-completion
	-- Code snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		requires = { "tami5/sqlite.lua" },
	},
	"zaldih/themery.nvim",
	"terrortylor/nvim-comment",
	"szw/vim-maximizer",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"numToStr/FTerm.nvim",
	"nvim-lua/plenary.nvim",
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	"windwp/nvim-ts-autotag",
	"nvim-treesitter/nvim-treesitter",
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	"f-person/git-blame.nvim",
	-- debugger stuff
	"mfussenegger/nvim-dap",
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {
			"microsoft/vscode-js-debug",
		},
		build = "cd ~/.local/share/nvim/lazy/vscode-js-debug && npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
		end,
	},
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				disable_inline_completion = false,
			})
		end,
	},
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	requires = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		-- keys = {
		-- 	{ "<leader>a", nil, desc = "AI/Claude Code" },
		-- 	{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		-- 	{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		-- 	{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		-- 	{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		-- 	{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
		-- 	{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		-- 	{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
		-- 	{
		-- 		"<leader>as",
		-- 		"<cmd>ClaudeCodeTreeAdd<cr>",
		-- 		desc = "Add file",
		-- 		ft = { "NvimTree", "neo-tree", "oil" },
		-- 	},
		-- 	-- Diff management
		-- 	{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		-- 	{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		-- },
	},
})
