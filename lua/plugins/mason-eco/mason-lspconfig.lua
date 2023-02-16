local M = {}

function M.setup()
  local mason_lspconfig_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
  if not mason_lspconfig_ok then
    print('The plugin [mason-lspconfig] not found. Please run :PackerSync!')
    return
  end

  mason_lspconfig.setup {
    ensure_installed = {
      'lua_ls',
      'jdtls',
      'bashls',
      'lemminx',
      'yamlls',
    }
  }
end

return M
