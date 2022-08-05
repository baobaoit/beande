local M = {}

function M.setup()
  require('toggleterm').setup {
    open_mapping = [[<C-\>]],
    direction = 'float',
    float_opts = {
      border = 'curved'
    }
  }
end

return M
