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
	"tanvirtin/monokai.nvim",
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
	},
	"zaldih/themery.nvim",
	"terrortylor/nvim-comment",
	"szw/vim-maximizer",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"numToStr/FTerm.nvim",
	"github/copilot.vim",
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
	"mfussenegger/nvim-dap",
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	"f-person/git-blame.nvim",
})
