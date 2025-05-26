-- Mason
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
-- A list of servers to automatically install if they're not already installed
require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
		"jsonls",
		"lua_ls",
		"pyright",
		"intelephense",
		"shmfmt",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"prettier", -- prettier formatter
		"stylua", -- lua formatter
		"black", -- python formatter
		"autopep8", -- another python formatter
		"prettierd", -- faster prettier
		"shmfmt", -- shell formatter
	},
})
