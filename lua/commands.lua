local api = vim.api

-- Show file path in command bar
api.nvim_create_user_command("ShowFilePath", function()
	print(vim.fn.expand("%:p"))
end, { bang = true })
