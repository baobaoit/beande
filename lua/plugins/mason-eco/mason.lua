local M = {}

function M.setup()
  local mason_ok, mason = pcall(require, 'mason')
  if not mason_ok then
    print('The plugin [mason] not found. Please run :PackerSync!')
    return
  end

  mason.setup {
    ui = {
      icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗'
      }
    }
  }
end

return M