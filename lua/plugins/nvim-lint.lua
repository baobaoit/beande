local M = {}

function M.setup()
  local lint_ok, lint = pcall(require, 'lint')
  if not lint_ok then
    vim.notify('The plugin [lint] not found. Please run :PackerSync!')
    return
  end

  lint.linters_by_ft = {
    java = { 'checkstyle' },
    lua = { 'luacheck' },
    sh = { 'shellcheck' },
    yaml = { 'yamllint' }
  }

  vim.api.nvim_create_autocmd({'BufWritePost'}, {
    pattern = { '*.java', '*.sh', '*.yaml' },
    callback = function()
      local lint_ok, lint = pcall(require, 'lint')
      if not lint_ok then
        vim.notify('The plugin [lint] not found. Please run :PackerSync!')
        return
      end
      
      lint.try_lint()
    end
  })

  vim.api.nvim_create_autocmd({'InsertLeave'}, {
    pattern = { '*.lua' },
    callback = function()
      local lint_ok, lint = pcall(require, 'lint')
      if not lint_ok then
        vim.notify('The plugin [lint] not found. Please run :PackerSync!')
        return
      end

      lint.try_lint()
    end
  })
end

return M
