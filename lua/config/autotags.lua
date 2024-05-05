require("nvim-treesitter.configs").setup({
	autotag = {
		enable = true,
	},
	opts = function(_, opts)
		if type(opts.ensure_installed) == "table" then
			vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
		end
	end,
})

-- Enable update on insert
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = {
		spacing = 5,
		severity_limit = "Warning",
	},
	update_in_insert = true,
})
