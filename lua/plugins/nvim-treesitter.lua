local M = {}

function M.setup()
  require('nvim-treesitter.configs').setup {
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
