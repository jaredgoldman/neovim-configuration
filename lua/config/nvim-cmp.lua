local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Helper to detect if supermaven completion is visible
local function is_supermaven_visible()
  local suggestion = require('supermaven-nvim.completion_preview')
  return suggestion.has_suggestion()
end

local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- First check for active LSP/snippet completions
			elseif cmp.get_active_entry() then
				cmp.complete()
			-- Then check if supermaven has completions
			elseif is_supermaven_visible() then
				-- Use supermaven's accept suggestion function
				local suggestion = require('supermaven-nvim.completion_preview')
				suggestion.on_accept_suggestion()
			-- Finally check for word completion
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	formatting = {
		fields = { "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.menu = ({
				nvim_lsp = "[Lsp]",
				luasnip = "[Luasnip]",
				buffer = "[File]",
				path = "[Path]",
				supermaven = "[SM]",
			})[entry.source.name]
			return vim_item
		end,
	},
	completion = {
		autocomplete = false, -- Disable automatic popup
		completeopt = 'menu,menuone,noinsert',
	},
	sources = cmp.config.sources({
		{ name = "supermaven", priority = 1000 }, -- Add supermaven as highest priority source
		{ name = "nvim_lsp", priority = 900 },
		{ name = "luasnip", priority = 750 },
		{ name = "buffer", priority = 500 },
		{ name = "path", priority = 250 },
	}),
})

-- Add this to control when cmp opens automatically
vim.api.nvim_create_autocmd("TextChangedI", {
	callback = function()
		local line = vim.api.nvim_get_current_line()
		local cursor = vim.api.nvim_win_get_cursor(0)[2]

		-- Don't open cmp if supermaven is visible
		if is_supermaven_visible() then
			return
		end

		-- Trigger cmp in appropriate contexts
		local before_char = string.sub(line, cursor, cursor)
		if before_char:match("[.:]") then
			cmp.complete()
		end
	end,
})
