local M = {}

function M.setup()
  local fidget_ok, fidget = pcall(require, 'fidget')
  if not fidget_ok then
    print('The plugin [fidget] not found. Please run :PackerSync!')
    return
  end

  fidget.setup {
    text = {
      spinner = 'bouncing_bar'
    }
  }
end

return M
