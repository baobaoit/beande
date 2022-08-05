local M = {}

function M.setup()
  require('mason-lspconfig').setup {
    ensure_installed = {
      'sumneko_lua',
      'jdtls',
      'bashls',
      'lemminx',
      'yamlls',
      'luachecks',
      'shellcheck',
      'yamllint'
    }
  }
end

return M