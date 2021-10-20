--[[
 ╔════════════════════════════╗
 ║ Plugin settings for Neovim ║
 ╚════════════════════════════╝
--]]
local utils = require "utils"
local plugin_settings_folder_name = utils.get_plugin_settings_folder_name()
utils.require_plugins {
  [plugin_settings_folder_name] = {
    "impatient_nvim",
    "ale",
    "bufferline_nvim",
    "diffview_nvim",
    "lspkind_nvim",
    "lsp_spinner_nvim",
    "lualine_nvim",
    "nvim_autopairs",
    "nvim_cmp",
    "nvim_dap",
    "nvim_dap_ui",
    "nvim_lspconfig",
    "nvim_tree",
    "nvim_treesitter",
    "nvim_web_devicons",
    "onedark_nvim",
    "symbols_outline_nvim",
    "telescope_nvim",
    "toggleterm_nvim",
    "vim_lengthmatters",
  }
}
