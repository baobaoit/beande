--[[
 ╔═══════════════════════════════════╗
 ║ Settings for hoob3rt/lualine.nvim ║
 ╚═══════════════════════════════════╝
--]]
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch','diff'},
    lualine_c = {
      {
        'filename',
        -- 0 = just filename, 1 = relative path, 2 = absolute path
        path = 1
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {
    -- Lualine extensions change statusline appearance for a window/buffer with specified filetypes.
    -- By default no extension are loaded to improve performance.
    -- Available extensions: 'chadtree','fugitive','fzf','nerdtree','nvim-tree','quickfix'
  }
}
