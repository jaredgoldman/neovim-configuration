require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettierd", "prettier" },
		typescript = { "prettierd", "prettier" },
		javascriptreact = { "prettierd", "prettier" },
		typescriptreact = { "prettierd", "prettier" },
		json = { "prettierd", "prettier" },
		jsonc = { "prettierd", "prettier" },
		markdown = { "marksman", "prettier", "prettierd" },
		python = { "black", "autopep8" },
		html = { "html-lsp", "prettier", "prettierd" }, -- Added HTML support
		sh = { "shfmt" },
	},
	stop_after_first = {
		lua = true,
		javascript = true,
		typescript = true,
		javascriptreact = true,
		typescriptreact = true,
		json = true,
		jsonc = true,
		markdown = true,
		python = true,
		html = true, -- Added stop condition for HTML
		sh = true,
	},
})
local M = {}
M.format = function(args)
	local range = nil
	if args and args.count ~= -1 then
		-- Assuming args.line1 and args.line2 are provided and valid
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_fallback = true, range = range })
end
vim.api.nvim_create_user_command("Format", function(args)
	M.format(args)
end, { range = true })
return M
