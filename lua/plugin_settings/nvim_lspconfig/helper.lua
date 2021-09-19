--[[
 ╔═══════════════════════════════════╗
 ║ Helpers for neovim/nvim-lspconfig ║
 ╚═══════════════════════════════════╝
--]]
local M = {}
local lsp_spinner = require("lsp_spinner")

function M.get_extended_capabilities()
  -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
  -- Add additional capabilities supported by nvim-cmp
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- turn on `window/workDoneProgress` capability
  lsp_spinner.init_capabilities(capabilities)
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  return capabilities
end


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
  lsp_spinner.on_attach(client, bufnr)

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

local fn = vim.fn
local jdtls_home = os.getenv "JDTLS_HOME"
local user_home = os.getenv "HOME"
local sys_name = vim.loop.os_uname().sysname

function M.get_jdtls_config()
  local folder_config = "config_linux"
  if sys_name:match "Darwin" then
    folder_config = "config_mac"
  elseif sys_name:match "Windows" then
    folder_config = "config_win"
  end
  return jdtls_home .. "/" .. folder_config
end

function M.get_jdtls_jar()
  return fn.expand(jdtls_home .. "/plugins/org.eclipse.equinox.launcher_*.jar")
end

function M.get_java_debug_jar()
  return fn.expand(user_home .. "/.config/nvim/java-debug/com.microsoft.java.debug.plugin-*.jar")
end

function M.get_lua_language_server_env()
  local system_name = "Linux"
  if fn.has("mac") == 1 then
    system_name = "macOS"
  elseif fn.has("win32") == 1 then
    system_name = "Windows"
  end
  return system_name
end

return M
