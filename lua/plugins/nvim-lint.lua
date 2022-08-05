local M = {}

function M.setup()
  require('lint').linters_by_ft = {
    java = { 'checkstyle' },
    lua = { 'luacheck' },
    sh = { 'shellcheck' },
    yaml = { 'yamllint' }
  }

  vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern = { '*.java', '*.sh', '*.yaml' },
    callback = function()
      require('lint').try_lint()
    end
  })

  vim.api.nvim_create_autocmd({'InsertLeave'}, {
    pattern = { '*.lua' },
    callback = function()
      require('lint').try_lint()
    end
  })
end

return M
