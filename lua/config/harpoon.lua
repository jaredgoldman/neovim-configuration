local api = vim.api
local harpoon = require("harpoon")
harpoon.setup({})

api.nvim_create_user_command('HarpoonAdd', function() harpoon:list():add() end, { bang = true })
api.nvim_create_user_command('HarpoonUI', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { bang = true })
api.nvim_create_user_command('HarpoonTogglePrev', function() harpoon:list():prev() end, { bang = true })
api.nvim_create_user_command('HarpoonToggleNext', function() harpoon:list():next() end, { bang = true })
