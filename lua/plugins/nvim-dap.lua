local M = {}

function M.setup()
  local dap_ok, dap = pcall(require, 'dap')
  if not dap_ok then
    vim.notify('The plugin [dap] not found. Please run :PackerSync!')
    return
  end

  dap.configurations.java = {
    {
      type = "java";
      request = "attach";
      name = "Debug (Attach) - Remote";
      hostName = "127.0.0.1";
      port = 5005;
    },
  }
  
  vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
end

return M
