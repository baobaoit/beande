local M = {}

function M.setup()
  local onedark_ok, onedark = pcall(require, 'onedark')
  if not onedark_ok then
    vim.notify('The plugin [onedark] not found. Please run :PackerSync!')
    return
  end

  onedark.setup {
    style = 'darker',

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'italic',
        functions = 'bold',
        strings = 'none',
        variables = 'none'
    },
  }
  onedark.load()
end

return M
