--[[
 ╔══════════════════════════════════════╗
 ║ Settings for akinsho/toggleterm.nvim ║
 ╚══════════════════════════════════════╝
--]]
require'toggleterm'.setup {
  direction = 'horizontal', -- 'vertical' | 'horizontal' | 'window' | 'float',
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
    -- width = <value>,
    -- height = <value>,
    highlights = {
      background = 'Normal',
      border = 'Normal',
    }
  },
  hide_numbers = true, -- hide the number column in toggleterm buffers
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  open_mapping = [[<C-\>]],
  persist_size = true,
  shade_terminals = true,
  -- size can be a number or function which is passed the current terminal
  -- size = 20 | function(term)
  size = function(term)
    if term.direction == 'horizontal' then
      return 15
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.4
    end
  end,
}
