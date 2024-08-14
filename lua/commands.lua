local utils = require("utils")
local api = vim.api

-- Show file path in command bar
api.nvim_create_user_command("ShowFilePath", function()
  print(vim.fn.expand("%:p"))
end, { bang = true })

-- Toggle wrap
vim.api.nvim_create_user_command("ToggleWrap", function()
  if vim.wo.wrap then
    vim.wo.wrap = false
    print("Word wrap disabled")
  else
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.wo.breakindent = true
    print("Word wrap enabled")
  end
end, {})

-- Register the command
api.nvim_create_user_command("FindAndReplace", utils.find_and_replace, {})
