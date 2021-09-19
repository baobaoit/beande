--[[
 ╔════════════════════════════════════════╗
 ║ Settings for monsonjeremy/onedark.nvim ║
 ╚════════════════════════════════════════╝
--]]
require("onedark").setup {
-- Change the 'hint' color to the 'orange' color, and make the 'error' color bright red
  colors = { hint = 'orange', error = '#ff0000' },
  sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' },
  transparent = true,
}

-- Load the colorscheme
vim.cmd [[colorscheme onedark]]
