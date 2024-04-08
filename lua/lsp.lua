local lspconfig = require("lspconfig")

   local mappings = {
	["<leader>k"] = vim.diagnostic.open_float,
	["[d"] = vim.diagnostic.goto_prev,
	["]d"] = vim.diagnostic.goto_next,
	["<leader>q"] = vim.diagnostic.setloclist,
	["gD"] = vim.lsp.buf.declaration,
	["gd"] = vim.lsp.buf.definition,
	["K"] = vim.lsp.buf.hover,
	["gi"] = vim.lsp.buf.implementation,
	["<leader>wa"] = vim.lsp.buf.add_workspace_folder,
	["<leader>wr"] = vim.lsp.buf.remove_workspace_folder,
	["<leader>wl"] = function()
		print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
	end,
	["<leader>D"] = vim.lsp.buf.type_definition,
	["<leader>rn"] = vim.lsp.buf.rename,
	["<leader>ca"] = vim.lsp.buf.code_action,
	["gr"] = vim.lsp.buf.references,
	["<leader>fm"] = function()
		vim.lsp.buf.format({ async = true })
	end,
}

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	for key, mapping in pairs(mappings) do
		vim.keymap.set("n", key, mapping, bufopts)
	end
end

local servers = {
	"tsserver",
	"intelephense",
	"tailwindcss",
	"lua_ls",
}

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
