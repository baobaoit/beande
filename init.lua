--------- Helpers ---------
local cmd = vim.cmd -- vim commands
local fn = vim.fn -- vim functions
local g = vim.g -- global variables
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

local function map(mode, lhs, rhs, opts) -- noremap
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

--------- Plugins ---------
require 'paq' {
-- Package manager
  'savq/paq-nvim'; -- Let Paq manage itself
-- Status bar
  'hoob3rt/lualine.nvim';
-- Theme
  'monsonjeremy/onedark.nvim';
-- File explorer
  'kyazdani42/nvim-tree.lua';
  'kyazdani42/nvim-web-devicons';
}

--------- hoob3rt/lualine.nvim ---------
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
--------- hoob3rt/lualine.nvim ---------

--------- monsonjeremy/onedark.nvim ---------
require'onedark'.setup {
  transparent = true,
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
  colors = { hint = "orange", error = "#ff0000" } 
}

-- Load the colorscheme
cmd[[colorscheme onedark]]
--------- monsonjeremy/onedark.nvim ---------

--------- kyazdani42/nvim-tree.lua ---------
-- 0 by default, opens the tree when typing `vim $DIR` or `vim`
g.nvim_tree_auto_open = 1

-- 0 by default, closes the tree when you open a file
g.nvim_tree_quit_on_open = 1

-- 0 by default, this option allows the cursor to be updated when entering a buffer
g.nvim_tree_follow = 1

-- 0 by default, will update the path of the current dir if the file is not inside the tree.
g.nvim_tree_follow_update_path = 1

-- 0 by default, this option shows indent markers when folders are open
g.nvim_tree_indent_markers = 1

-- 0 by default, this option hides files and folders starting with a dot `.`
g.nvim_tree_hide_dotfiles = 1

map('n', '<C-b>', ':NvimTreeToggle<CR>', { silent = true })
map('n', '<Leader>r', ':NvimTreeRefresh<CR>', { silent = true })
map('n', '<Leader>n', ':NvimTreeFindFile<CR>', { silent = true })

-- a list of groups can be found at `:help nvim_tree_highlight`
cmd[[au VimEnter * highlight NvimTreeFolderIcon guibg=blue]]
--------- kyazdani42/nvim-tree.lua ---------

--------- kyazdani42/nvim-web-devicons ---------
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 -- override = {
 --  zsh = {
 --    icon = "",
 --    color = "#428850",
 --    name = "Zsh"
 --  }
 -- };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

require'nvim-web-devicons'.has_loaded()

require'nvim-web-devicons'.get_icons()
--------- kyazdani42/nvim-web-devicons ---------

--------- Options ---------
local indent = 2
cmd 'set t_Co=256'
cmd 'syntax on'
cmd 'filetype indent plugin on'
opt('b', 'expandtab', true) -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent) -- Size of an indent
opt('b', 'smartindent', true) -- Insert indents automatically
opt('b', 'tabstop', indent) -- Number of spaces tabs count for
opt('o', 'mouse', 'a') -- Enable mouse
opt('o', 'termguicolors', true) -- True color support
opt('o', 'wildmode', 'list:longest') -- Command-line completion mode
opt('w', 'number', true) -- Print line number
