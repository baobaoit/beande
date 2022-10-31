local api = vim.api
local autocmd = api.nvim_create_autocmd
local augroup = api.nvim_create_augroup
local cmd = vim.cmd
local g = api.nvim_set_var
local map = vim.keymap.set
local o = api.nvim_set_option
local opt = api.nvim_buf_set_option
local wo = api.nvim_win_set_option

cmd [[filetype plugin indent on]]
g('mapleader', ' ')
o('completeopt', 'menu,menuone,noselect')
o('hidden', true)
o('listchars', 'eol:¬,tab:>·,trail:~,space:␣')
o('mouse', 'a')
o('shell', '/bin/zsh')
o('t_Co', '256')
o('tgc', true)
o('timeoutlen', 500) -- By default timeoutlen is 1000 ms
wo(0, 'nu', true)
wo(0, 'rnu', true)


local notify_ok, notify = pcall(require, 'notify')
if notify_ok then
  vim.notify = notify
end


local map_opts = { noremap = true, silent = true }
-- Escape the Terminal mode
map('t', '<Esc>', '<C-\\><C-n>', map_opts)
-- Neovim split navigation
local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
  wk.register({
    ['<A-h>'] = {
      '<Esc><C-w>h',
      'Navigate to the left window'
    },
    ['<A-j>'] = {
      '<Esc><C-w>j',
      'Navigate to the below window'
    },
    ['<A-k>'] = {
      '<Esc><C-w>k',
      'Navigate to the above window'
    },
    ['<A-l>'] = {
      '<Esc><C-w>l',
      'Navigate to the right window'
    },
    ['<leader>'] = {
      sl = {
        '<Cmd>set list!<cr>',
        'Show/Hidden special characters'
      }
    }
  }, {
    mode = 'n'
  })
end

autocmd({'FileType'}, {
    group = augroup('SetTab', {}),
    pattern = '*',
    callback = function()
      opt(0, 'et', true)
      opt(0, 'shiftwidth', 2)
      opt(0, 'ts', 2)
      opt(0, 'si', true)
    end
})
