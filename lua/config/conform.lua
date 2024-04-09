require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = { { "prettierd", "prettier" } },
		typescript = { { "prettierd", "prettier" } },
		json = { { "prettier", "prettierd" } },
		markdown = { { "marksman", "prettierd", "prettier" } },
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
