local M = {}

function M.setup()
  local mason_tool_installer_ok, mason_tool_installer = pcall(require, 'mason-tool-installer')
  if not mason_tool_installer_ok then
    print('The plugin [mason-tool-installer] not found. Please run :PackerSync!')
    return
  end

  mason_tool_installer.setup {
    ensure_installed = {
      'luacheck',
      'shellcheck',
      'yamllint',
      'java-debug-adapter'
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

