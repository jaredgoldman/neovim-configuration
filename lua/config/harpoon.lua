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

local function maybe_remove_add()
	local bufnr = api.nvim_get_current_buf()
	local mark = harpoon:mark(bufnr)
	if mark then
		harpoon:list():add()
	else
		harpoon:list():remove()
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
	maybe_remove_add()
end, { bang = true })
api.nvim_create_user_command("HarpoonTogglePrev", function()
	harpoon:list():prev()
end, { bang = true })
api.nvim_create_user_command("HarpoonToggleNext", function()
	harpoon:list():next()
end, { bang = true })
api.nvim_create_user_command("HarpoonUI", function()
	toggle_telescope(harpoon:list())
end, { bang = true })
