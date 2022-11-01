local M = {}

function M.setup()
  local nvim_treesitter_configs_ok, nvim_treesitter_configs = pcall(require, 'nvim-treesitter.configs')
  if not nvim_treesitter_configs_ok then
    vim.notify('The plugin [nvim-treesitter.configs] not found. Please run :PackerSync!')
    return
  end

  nvim_treesitter_configs.setup {
    -- A list of parser names, or "all"
    ensure_installed = { 'lua', 'java', 'bash', 'yaml', 'html' },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
      enable = true,
    },

    indent = {
      enable = true
    }
  }
end

return M
