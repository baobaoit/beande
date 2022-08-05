local M = {}

function M.setup()
  local navic = require('nvim-navic')
  require('lualine').setup {
    options = {
      theme = 'onedark',
      -- disabled_filetypes = {
      --   'java'
      -- }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch','diff'},
      lualine_c = {
        { navic.get_location, cond = navic.is_available }
      },
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    extensions = {
      -- Lualine extensions change statusline appearance for a window/buffer with specified filetypes.
      -- By default no extension are loaded to improve performance.
      -- Available extensions: 'chadtree','fugitive','fzf','nerdtree','nvim-tree','quickfix'
      'nvim-tree'
    }
  }
end

return M