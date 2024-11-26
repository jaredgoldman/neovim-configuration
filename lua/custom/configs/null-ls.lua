---------------------------------
-- Formatting
---------------------------------
local diagnostics = require("null-ls").builtins.diagnostics
local formatting = require("null-ls").builtins.formatting
local code_actions = require("null-ls").builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

require("null-ls").setup {
  debug = true,
  sources = {
    formatting.black,
    formatting.rustfmt,
    formatting.prettier,
    formatting.stylua,
    diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
    diagnostics.eslint_d.with { diagnostics_format = "#{m} [#{c}]" },
    code_actions.eslint,
    code_actions.eslint_d,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
