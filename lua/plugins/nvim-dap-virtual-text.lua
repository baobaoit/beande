local M = {}

function M.setup()
  local nvim_dap_virtual_text_ok, nvim_dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')
  if not nvim_dap_virtual_text_ok then
    print('The plugin [nvim-dap-virtual-text] not found. Please run :PackerSync!')
    return
  end

  nvim_dap_virtual_text.setup()
end

return M
