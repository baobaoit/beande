local M = {}

function M.setup()
  require('mason-tool-installer').setup {
    ensure_installed = {
      'luacheck',
      'shellcheck',
      'yamllint'
    }
  }
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MasonToolUpdateCompleted',
  callback = function()
    vim.schedule(function()
      print 'mason-tool-installer has finished'
    end)
  end
})

return M

