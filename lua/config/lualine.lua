-- local base16 = require'lualine.themes.base16'
-- local ayu_dark = require'lualine.themes.ayu_dark'
-- local base16 = require'lualine.themes.base16'
-- local codedark = require'lualine.themes.codedark'
local horizon = require'lualine.themes.horizon'

-- Change the background of lualine_c section for normal mode

require('lualine').setup {
  options = { theme  = horizon},
}
