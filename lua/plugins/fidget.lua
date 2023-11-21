local M = {}

function M.setup()
  local fidget_ok, fidget = pcall(require, 'fidget')
  if not fidget_ok then
    vim.notify('The plugin [fidget] not found. Please run :PackerSync!')
    return
  end

  fidget.setup {
    progress = {
      display = {
        progress_icon = {
          pattern = 'bouncing_bar'
        }
      }
    }
  }
end

return M
