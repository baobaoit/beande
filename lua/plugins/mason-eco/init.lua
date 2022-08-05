local M = {}

function M.setup()
  local plugins = {
    ['plugins.mason-eco'] = {
      'mason',
      'mason-lspconfig'
    }
  }

  for folder_name, plugin_list in pairs(plugins) do
    for _, plugin in ipairs(plugin_list) do
      local status_ok, plugin_required = pcall(require, folder_name..'.'..plugin)
      if not status_ok then
        print(string.format('Plugin %s caused error, please check your configuration.', plugin))
        return
      end

      plugin_required.setup()
    end
  end
end

return M
