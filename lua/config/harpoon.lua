local api = vim.api
local harpoon = require("harpoon")
harpoon.setup({})

api.nvim_create_user_command('HarpoonAdd', function() harpoon:list():add() end, { bang = true })
api.nvim_create_user_command('HarpoonTogglePrev', function() harpoon:list():prev() end, { bang = true })
api.nvim_create_user_command('HarpoonToggleNext', function() harpoon:list():next() end, { bang = true })

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

api.nvim_create_user_command('HarpoonUI', function() toggle_telescope(harpoon:list()) end, { bang = true })
