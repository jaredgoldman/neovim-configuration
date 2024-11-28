local cmp = require("cmp")

-- Track if user has actively selected an item
local actively_selected = false

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		-- Navigation only with C-j/C-k
		["<C-k>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
				actively_selected = true
			end
		end),
		["<C-j>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item()
				actively_selected = true
			end
		end),

		-- Enter always confirms the selected item
		["<CR>"] = cmp.mapping.confirm({ select = false }),

		-- Tab only confirms if we've actively selected something
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and actively_selected then
				cmp.confirm({ select = true })
				actively_selected = false
			else
				fallback() -- Let supermaven handle it
			end
		end, { "i", "s" }),

		-- Reset selection state when manually closing menu
		["<C-e>"] = cmp.mapping(function()
			actively_selected = false
			cmp.close()
		end),
	}),
	-- Rest of your config remains the same
	formatting = {
		fields = { "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[Lsp]",
				luasnip = "[Luasnip]",
				buffer = "[File]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})
