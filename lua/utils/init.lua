--[[
 ╔═══════════╗
 ║ Utilities ║
 ╚═══════════╝
--]]
local api = vim.api
local M = {}

function M.augroups(definitions)
  for group_name, definition in pairs(definitions) do
    api.nvim_command('augroup '..group_name)
    api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      -- if type(def) == 'table' and type(def[#def]) == 'function' then
      --   def[#def] = lua_callback(def[#def])
      -- end
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      api.nvim_command(command)
    end
    api.nvim_command('augroup END')
  end
end

function M.map(mode, lhs, rhs, opts) -- noremap
  local options = {noremap = true, silent = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.require_plugins(plugin_settings)
  for folder_name, plugin_names in pairs(plugin_settings) do
    for _, plugin_name in ipairs(plugin_names) do
      local plugin_setting_path = folder_name..'.'..plugin_name
      require(plugin_setting_path)
    end
  end
end

function M.get_plugin_settings_folder_name()
  return 'plugin_settings'
end

function M.get_nvim_lspconfig_folder_name()
  return 'nvim_lspconfig'
end

return M
