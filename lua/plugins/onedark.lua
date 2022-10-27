local M = {}

function M.setup()
  local onedark_ok, onedark = pcall(require, 'onedark')
  if not onedark_ok then
    print('The plugin [onedark] not found. Please run :PackerSync!')
    return
  end

  onedark.setup {
    style = 'darker'
  }
  onedark.load()
end

return M