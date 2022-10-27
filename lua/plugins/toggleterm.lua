local M = {}

function M.setup()
  local toggleterm_ok, toggleterm = pcall(require, 'toggleterm')
  if not toggleterm_ok then
    print('The plugin [toggleterm] not found. Please run :PackerSync!')
    return
  end

  toggleterm.setup {
    open_mapping = [[<C-\>]],
    direction = 'float',
    float_opts = {
      border = 'curved'
    }
  }
end

return M
