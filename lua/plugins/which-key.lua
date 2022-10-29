local M = {}

function M.setup()
  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    vim.notify('The plugin [which-key] not found. Please run :PackerSync!')
    return
  end

  wk.setup {
    key_labels = {
      ['<space>'] = 'SPC',
      ['<leader>'] = 'SPC',
      ['<cr>'] = 'RET',
      ['<C>'] = 'CTRL',
      ['<M>'] = 'ALT',
    },
  }

  wk.register({
    ['<space>'] = {
      e = 'Diagnostic open float',
      q = 'Diagnostic set loclist',
      w = {
        a = 'Add workspace folder',
        r = 'Remove workspace folder',
        l = 'List workspace folders',
      },
      D = 'Type definition',
      r = {
        n = 'Rename',
        t = {
          ':lua require("dap").repl.toggle()<CR>',
          'REPL toggle'
        },
        l = {
          ':lua require("dap").run_last()<CR>',
          'Run last'
        }
      },
      ca = 'Code action',
      f = 'Formatting',
      t = {
        f = {
          '<cmd>Telescope find_files<cr>',
          'Telescope find files'
        },
        g = {
          '<cmd>Telescope live_grep<cr>',
          'Telescope live grep'
        },
        b = {
          '<cmd>Telescope buffers<cr>',
          'Telescope buffers'
        }
      },
      b = {
        ':lua require("dap").toggle_breakpoint()<CR>',
        'Toggle breakpoint'
      },
      B = {
        ':lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
        'Set breakpoint condition'
      },
      lp = {
        ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
        'Set log point message'
      },
      d = {
        e = {
          ':lua require("dapui").eval()<CR>',
          'DAP UI eval'
        },
        c = {
          ':lua require("dap").continue()<CR>',
          'Debug continue'
        },
        s = {
          o = {
            ':lua require("dap").step_over()<CR>',
            'Step over'
          },
          O = {
            ':lua require("dap").step_out()<CR>',
            'Step out'
          },
          i = {
            ':lua require("dap").step_into()<CR>',
            'Step into'
          }
        },
        t = {
          ':lua require("dap").terminate()<CR> :lua require("dapui").close()<CR>',
          'Terminates the debug session'
        }
      },
      cb = {
        ':lua require("dap").clear_breakpoints()<CR>',
        'Clear breakpoints'
      },
      yy = {
        '"+y<cr>',
        'Copy to clipboard'
      },
      p = {
        '"+p<cr>',
        'Paste from clipboard'
      },
      ntt = {
        ':NvimTreeToggle<cr>',
        'Nvim Tree toggle'
      }
    },
    ['[d'] = 'Diagnostic go to prev',
    [']d'] = 'Diagnostic go to next',
    g = {
      D = 'Go to declaration',
      d = 'Go to definition',
      i = 'Go to implementation',
      r = 'Go to reference'
    },
    K = 'Hover',
    ['<C-k>'] = 'Signature help',
    [']b'] = {
      ':BufferLineCycleNext<CR>',
      'Buffer next'
    },
    ['[b'] = {
      ':BufferLineCyclePrev<CR>',
      'Buffer prev'
    },
  })

  wk.register({
    ['<space>'] = {
      de = {
        ':lua require("dapui").eval()<CR>',
        'DAP UI eval'
      },
      yy = {
        '"+y',
        'Copy to clipboard'
      },
      p = {
        '"+p',
        'Paste from clipboard'
      }
    }
  }, {
    mode = 'v'
  })

  wk.register({
    jk = {
      '<Esc>',
      'Escape the insert mode'
    }
  }, {
    mode = 'i'
  })
end

return M
