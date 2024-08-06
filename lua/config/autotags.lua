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
		min = vim.diagnostic.severity.WARN, -- Updated from severity_limit
	},
	update_in_insert = true,
})
-- severity_limit is deprecated, use {min = severity} See vim.diagnostic.severity instead. :help deprecated Feature will be removed in Nvim 0.11
