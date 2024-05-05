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
		"tsserver",
		"jsonls",
		"lua_ls",
	},
})
