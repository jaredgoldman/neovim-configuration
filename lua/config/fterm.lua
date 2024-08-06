local api = vim.api
local fterm = require("FTerm")

fterm.setup({
	blend = 25,
})

-- Commands
api.nvim_create_user_command("FTermToggle", fterm.toggle, { bang = true })
api.nvim_create_user_command("FTermClose", fterm.close, { bang = true })
