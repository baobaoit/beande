--[[
  ____              _                 _ _
 | __ )  __ _  ___ | |__   __ _  ___ (_) |_
 |  _ \ / _` |/ _ \| '_ \ / _` |/ _ \| | __|
 | |_) | (_| | (_) | |_) | (_| | (_) | | |
 |____/ \__,_|\___/|_.__/ \__,_|\___/|_|\__|
--]]

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
  "sindrets/diffview.nvim";
  "tpope/vim-fugitive";
-- Improve startup time
  "lewis6991/impatient.nvim";
-- Status bar
  "doums/lsp_spinner.nvim";
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
-- Lightbulb
  "kosayoda/nvim-lightbulb";
-- Debug
  "mfussenegger/nvim-dap";
  "rcarriga/nvim-dap-ui";
-- Java JDT.LS
  "neovim/nvim-lspconfig";
  "mfussenegger/nvim-jdtls";
-- File explorer
  "kyazdani42/nvim-tree.lua";
  "kyazdani42/nvim-web-devicons";
-- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  };
-- Theme
  "monsonjeremy/onedark.nvim";
-- Symbols outline
  "simrat39/symbols-outline.nvim";
-- Telescope
  "nvim-lua/plenary.nvim";
  "nvim-telescope/telescope.nvim";
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make"
  };
  "gbrlsnchs/telescope-lsp-handlers.nvim";
-- Terminal
  "akinsho/toggleterm.nvim";
-- Length over
  "whatyouhide/vim-lengthmatters";
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
