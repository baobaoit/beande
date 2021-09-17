--[[
 ╔═══════════╗
 ║ Bootstrap ║
 ╚═══════════╝
--]]
require "bootstrap"

--[[
 ╔═════════╗
 ║ Plugins ║
 ╚═════════╝
--]]
require "paq" {
-- Package manager
  "savq/paq-nvim"; -- Let Paq manage itself
-- Code analyze
  "dense-analysis/ale";
-- Buffer line
  "akinsho/bufferline.nvim";
-- Git
  "lewis6991/gitsigns.nvim";
  "tpope/vim-fugitive";
-- Status bar
  "hoob3rt/lualine.nvim";
-- Auto pairs
  "windwp/nvim-autopairs";
-- Completion
  "L3MON4D3/LuaSnip";
  "hrsh7th/cmp-buffer";
  "saadparwaiz1/cmp_luasnip";
  "hrsh7th/cmp-nvim-lsp";
  "onsails/lspkind-nvim";
  "hrsh7th/nvim-cmp";
  "hrsh7th/vim-vsnip";
-- Debug
  "mfussenegger/nvim-dap";
  "rcarriga/nvim-dap-ui";
-- File explorer
  "kyazdani42/nvim-tree.lua";
  "kyazdani42/nvim-web-devicons";
-- Theme
  "monsonjeremy/onedark.nvim";
-- Java JDT.LS
  "neovim/nvim-lspconfig";
  "mfussenegger/nvim-jdtls";
-- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  };
-- Telescope
  "nvim-lua/plenary.nvim";
  "nvim-telescope/telescope.nvim";
-- Terminal
  "akinsho/toggleterm.nvim";
}

--[[
 ╔═════════════════════════════╗
 ║ General settings for Neovim ║
 ╚═════════════════════════════╝
--]]
require "general"

--[[
 ╔════════════════════════════╗
 ║ Plugin settings for Neovim ║
 ╚════════════════════════════╝
--]]
require "plugin_settings"
