local M = {}

function M.setup()
  local dapui_ok, dapui = pcall(require, 'dapui')
  if not dapui_ok then
    vim.notify('The plugin [dapui] not found. Please run :PackerSync!')
    return
  end

  dapui.setup()

  -- Replicated auto-open behavior.
  local dap = require('dap')
  dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
  dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
  dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
end

return M
