-- define your colorscheme here
local colorscheme = 'monokai_pro'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end

vim.api.nvim_create_augroup('WinHighlight', {clear = true})
vim.api.nvim_create_autocmd({'ColorScheme'}, {
  group = 'WinHighlight',
  callback = function()
    vim.api.nvim_set_hl(0, 'VertSplit', {fg = '#ff0000'})
  end
})
