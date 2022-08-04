local M = {}

function M.setup()
  require('fidget').setup {
    text = {
      spinner = 'bouncing_bar'
    }
  }
end

return M
