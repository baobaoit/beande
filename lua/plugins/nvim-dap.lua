local M = {}

function M.setup()
  local dap = require('dap')
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
