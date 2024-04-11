local api = vim.api
local harpoon = require("harpoon")
harpoon.setup({})
-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

local function toggle_mark()
	local current_file = api.nvim_buf_get_name(0) -- Get the current buffer's file path
	local item, index = harpoon:list():get_by_value(current_file)
	if item then
		harpoon:list():remove_at(index)
		print("Removed from Harpoon: " .. current_file)
	else
		harpoon:list():add({ value = current_file })
		print("Added to Harpoon: " .. current_file)
	end
end

-- Commands
api.nvim_create_user_command("HarpoonClear", function()
	harpoon:list():clear()
end, { bang = true })
api.nvim_create_user_command("HarpoonAdd", function()
	harpoon:list():add()
end, { bang = true })
api.nvim_create_user_command("HarpoonToggleFile", function()
	toggle_mark()
end, { bang = true })
api.nvim_create_user_command("HarpoonUI", function()
	toggle_telescope(harpoon:list())
end, { bang = true })
