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
  "lewis6991/gitsigns.nvim";
  "tpope/vim-fugitive";
-- Improve startup time
  "lewis6991/impatient.nvim";
-- Status bar
  {
    "baobaoit/lsp_spinner.nvim",
    branch = "pre-15504"
  };
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
