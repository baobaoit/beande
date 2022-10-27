local M = {}

function M.setup()
  local bufferline_ok, bufferline = pcall(require, 'bufferline')
  if not bufferline_ok then
    print('The plugin [bufferline] not found. Please run :PackerSync!')
    return
  end

  bufferline.setup {
    options = {
      separator_style = 'slant',
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left"
        }
      }
    }
  }
end

return M
