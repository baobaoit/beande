local M = {}

function M.setup()
  local telescope_ok, telescope = pcall(require, 'telescope')
  if not telescope_ok then
    print('The plugin [telescope] not found. Please run :PackerSync!')
    return
  end

  local telescope_themes_ok, telescope_themes = pcall(require, 'telescope.themes')
  if not telescope_themes_ok then
    print('The plugin [telescope.themes] not found. Please run :PackerSync!')
    return
  end

  telescope.setup {
    extensions = {
      ["ui-select"] = {
        telescope_themes.get_dropdown {}
      }
    }
  }

  telescope.load_extension('ui-select')
end

return M
