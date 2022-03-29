--[[
 ╔═══════════════════════╗
 ║ Setup for Sumneko Lua ║
 ╚═══════════════════════╝
--]]
local user_home = os.getenv "HOME"
local utils = require "utils"
local plugin_settings_nvim_lspconfig_path = utils.get_plugin_settings_folder_name() .. "." .. utils.get_nvim_lspconfig_folder_name()
-- set the path to the sumneko installation;
local sumneko_root_path = user_home .. "/.config/nvim/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          vim.api.nvim_get_runtime_file("", true),
          "${3rd}/love2d/library"
        },
        maxPreload = 10000,
        preloadFileSize = 10000,
        checkThirdParty = false
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      completion = {
        workspaceWord = false
      },
    }
  },
}
