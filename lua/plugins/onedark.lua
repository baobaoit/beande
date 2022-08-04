local M = {}

function M.setup()
  local onedark = require('onedark')

  onedark.setup {
    style = 'darker'
  }
  onedark.load()
end

return M