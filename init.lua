--[[
  ____              _                 _ _
 | __ )  __ _  ___ | |__   __ _  ___ (_) |_
 |  _ \ / _` |/ _ \| '_ \ / _` |/ _ \| | __|
 | |_) | (_| | (_) | |_) | (_| | (_) | | |
 |____/ \__,_|\___/|_.__/ \__,_|\___/|_|\__|
--]]
local packer_bootstrap = require('bootstrap').packer_bootstrap

require('packer').startup(function(use)
  -- Make sure to add this line to let packer manage itself
  use 'wbthomason/packer.nvim'

  -- Auto pairs
  use {
    'windwp/nvim-autopairs',
    config = function()
      local nvim_autopairs_ok, nvim_autopairs = pcall(require, 'nvim-autopairs')
      if not nvim_autopairs_ok then
        print('The plugin [nvim-autopairs] not found. Please run :PackerSync!')
        return
      end

      nvim_autopairs.setup {}
    end
  }

  -- Buffer line
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Comment
  use {
    'numToStr/Comment.nvim',
    config = function()
        local Comment_ok, Comment = pcall(require, 'Comment')
        if not Comment_ok then
          print('The plugin [Comment] not found. Please run :PackerSync!')
          return
        end

        Comment.setup()
    end
  }

  -- Completion
  use {
    'L3MON4D3/LuaSnip', -- Snippets plugin
    'hrsh7th/cmp-nvim-lua', -- Neovim Lua API source for nvim-cmp
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/nvim-cmp', -- Autocompletion plugin
    'onsails/lspkind-nvim',
    'rcarriga/cmp-dap', -- Source for nvim-dap REPL and nvim-dap-ui buffers
    'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
  }

  -- File explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    }
  }

  -- Indent
  use 'lukas-reineke/indent-blankline.nvim'

  -- Java JDT.LS
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-jdtls'
  use {
    'rcarriga/nvim-dap-ui',
    requires = 'mfussenegger/nvim-dap'
  }
  use 'theHamsta/nvim-dap-virtual-text'

  -- Linter
  use 'mfussenegger/nvim-lint'

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  -- Status bar
  use 'j-hui/fidget.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  -- use 'windwp/windline.nvim'

  -- Startup
  use 'lewis6991/impatient.nvim'

  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'nvim-telescope/telescope-ui-select.nvim' }

  -- Terminal
  use {
    'akinsho/toggleterm.nvim',
    tag = 'v2.*'
  }

  -- Theme
  use 'navarasu/onedark.nvim'

  -- Which key
  use 'folke/which-key.nvim'

  -- Winbar
  use {
    'SmiteshP/nvim-navic',
    requires = 'neovim/nvim-lspconfig'
  }

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

require('plugins')

require('general')
