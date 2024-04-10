-- Set custom name to the list
require("themery").setup({
	themes = {
		{
			name = "Day",
			colorscheme = "catppuccin-frappe",
		},
		-- {
		--   name = "Afternoon",
		--   colorscheme = "nvim-grey",
		-- },
		{
			name = "Night",
			colorscheme = "catppuccin-mocha",
		},
	},
	themeConfigFile = "~/.config/nvim/lua/config/theme.lua", -- Desibed below
	livePreview = true, -- Apply theme while browsing. Default to true.
})
