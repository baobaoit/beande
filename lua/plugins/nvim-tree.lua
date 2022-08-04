local M = {}

function M.setup()
  require('nvim-tree').setup {
    renderer = {
      indent_markers = {
        -- 0 by default, this option shows indent markers when folders are open
        enable = true
      },
      -- 0 by default, compact folders that only contain a single folder into one node in the file tree
      group_empty = true
    }
  }
end

return M
