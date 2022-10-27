local M = {}

function M.setup()
  -- luasnip setup
  local luasnip_ok, luasnip = pcall(require, 'luasnip')
  if not luasnip_ok then
    print('The plugin [luasnip] not found. Please run :PackerSync!')
    return
  end

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  -- nvim-cmp setup
  local cmp_ok, cmp = pcall(require, 'cmp')
  if not cmp_ok then
    print('The plugin [cmp] not found. Please run :PackerSync!')
    return
  end

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lua' },
    },
    formatting = {
      format = function(entry, vim_item)
        -- fancy icons and a name of kind
        local lspkind_ok, lspkind = pcall(require, 'lspkind')
        if not lspkind_ok then
          print('The plugin [lspkind] not found. Please run :PackerSync!')
          return
        end

        vim_item.kind = lspkind.presets.default[vim_item.kind] .. ' ' .. vim_item.kind
  
        -- set a name for each source
        vim_item.menu = ({
          buffer = '[Buffer]',
          nvim_lsp = '[LSP]',
          luasnip = '[LuaSnip]',
          nvim_lua = '[Lua]',
          dap = '[DAP]',
        })[entry.source.name]
        return vim_item
      end,
    },
  }

  -- If you want insert `(` after select function or method item
  local cmp_autopairs_ok, cmp_autopairs = pcall(require, 'nvim-autopairs.completion.cmp')
  if not cmp_autopairs_ok then
    print('The plugin [nvim-autopairs.completion.cmp] not found. Please run :PackerSync!')
    return
  end
  
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({
    map_char = {
      tex = ''
    }
  }))

  cmp.setup.filetype({ 'dap-repl', 'dapui_watches' }, {
    sources = {
      { name = 'dap' },
    }
  })
end

return M
