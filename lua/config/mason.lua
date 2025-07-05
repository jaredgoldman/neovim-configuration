-- Mason
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

-- A list of servers to automatically install if they're not already installed
require("mason-lspconfig").setup({
	ensure_installed = {
		"ts_ls",
		"jsonls",
		"lua_ls",
		"pyright",
		"intelephense",
		-- New additions
		"html", -- HTML LSP
		"bashls", -- Bash LSP
		"yamlls", -- YAML LSP
		"sqlls", -- SQL LSP
    "marksman", -- Markdown LSP
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"black",
		"autopep8",
		"prettierd",
		-- New additions
		-- JavaScript/TypeScript
		"eslint_d", -- Fast ESLint daemon
		-- Python
		"ruff", -- Fast Python linter/formatter
		"isort", -- Python import sorter
		"mypy", -- Python type checker
		-- PHP
		"php-cs-fixer", -- PHP formatter
		"phpstan", -- PHP static analyzer
		-- Bash
		"shellcheck", -- Shell script linter
		"shfmt", -- Shell formatter
		-- YAML
		"yamllint", -- YAML linter
		-- SQL
		"sqlfluff", -- SQL linter and formatter
	},
})
