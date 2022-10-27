local M = {}

function M.setup()
  local nvim_tree_ok, nvim_tree = pcall(require, 'nvim-tree')
  if not nvim_tree_ok then
    print('The plugin [nvim-tree] not found. Please run :PackerSync!')
    return
  end

  nvim_tree.setup {
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
