--[[
 ╔═══════════╗
 ║ Bootstrap ║
 ╚═══════════╝
--]]
require'bootstrap'

--[[
 ╔═════════╗
 ║ Plugins ║
 ╚═════════╝
--]]
require 'paq' {
-- Package manager
  'savq/paq-nvim'; -- Let Paq manage itself
-- Code analyze
  'dense-analysis/ale';
-- Buffer line
  'akinsho/bufferline.nvim';
-- Status bar
  'hoob3rt/lualine.nvim';
-- Auto pairs
  'windwp/nvim-autopairs';
-- Completion
  'L3MON4D3/LuaSnip';
  'hrsh7th/cmp-buffer';
  'hrsh7th/cmp-nvim-lsp';
  'onsails/lspkind-nvim';
  'hrsh7th/nvim-cmp';
  'hrsh7th/vim-vsnip';
-- Debug
  'mfussenegger/nvim-dap';
-- File explorer
  'kyazdani42/nvim-tree.lua';
  'kyazdani42/nvim-web-devicons';
-- Theme
  'monsonjeremy/onedark.nvim';
-- Java JDT.LS
  'neovim/nvim-lspconfig';
  'mfussenegger/nvim-jdtls';
-- Syntax highlighting
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  };
-- Telescope
  'nvim-lua/plenary.nvim';
  'nvim-telescope/telescope.nvim';
-- Terminal
  'akinsho/toggleterm.nvim';
}

--[[
 ╔════════════════════════════╗
 ║ Plugin settings for Neovim ║
 ╚════════════════════════════╝
--]]
require'plugin_settings'

--[[
 ╔═════════════════════════════╗
 ║ General settings for Neovim ║
 ╚═════════════════════════════╝
--]]
require'general'
