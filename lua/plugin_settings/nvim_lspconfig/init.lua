--[[
 ╔════════════════════════════════════╗
 ║ Settings for neovim/nvim-lspconfig ║
 ╚════════════════════════════════════╝
--]]
local nvim_lsp = require "lspconfig"
local utils = require "utils"
local plugin_settings_folder_name = utils.get_plugin_settings_folder_name()
local nvim_lspconfig_folder_name = utils.get_nvim_lspconfig_folder_name()
local plugin_settings_nvim_lspconfig_path = plugin_settings_folder_name .. "." .. nvim_lspconfig_folder_name
local helper = require(plugin_settings_nvim_lspconfig_path .. ".helper")
local on_attach_customize = helper.on_attach
local capabilities_customize = helper.get_extended_capabilities()
local servers = {
  "bashls",
  "jdtls",
  "sumneko_lua",
  "vimls",
  "yamlls",
  "lemminx"
}

for _, lsp in ipairs(servers) do
  local lsp_config = require(plugin_settings_nvim_lspconfig_path .. "." .. lsp .. "_setup")
  lsp_config.capabilities = capabilities_customize
  lsp_config.flags = {
    debounce_text_changes = 150
  }
  lsp_config.on_attach = on_attach_customize
  nvim_lsp[lsp].setup(lsp_config)
end
