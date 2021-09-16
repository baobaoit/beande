--[[
 ╔════════════════════════════╗
 ║ Plugin settings for Neovim ║
 ╚════════════════════════════╝
--]]
local utils = require "utils"
local plugin_settings_folder_name = utils.get_plugin_settings_folder_name()
utils.require_plugins {
  [plugin_settings_folder_name] = {
    "ale",
    "bufferline_nvim",
    "lspkind_nvim",
    "lualine_nvim",
    "nvim_autopairs",
    "nvim_cmp",
    "nvim_dap",
    "nvim_lspconfig",
    "nvim_tree",
    "nvim_treesitter",
    "nvim_web_devicons",
    "onedark_nvim",
    "telescope_nvim",
    "toggleterm_nvim",
  }
}
