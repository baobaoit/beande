local M = {}

function M.setup()
  local indent_blankline_ok, indent_blankline = pcall(require, 'indent_blankline')
  if not indent_blankline_ok then
    print('The plugin [indent_blankline] not found. Please run :PackerSync!')
    return
  end

  indent_blankline.setup()
end

return M
