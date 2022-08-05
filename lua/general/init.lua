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
o('mouse', 'a')
o('shell', '/bin/zsh')
o('t_Co', '256')
o('tgc', true)
o('timeoutlen', 500) -- By default timeoutlen is 1000 ms
wo(0, 'nu', true)
wo(0, 'rnu', true)

local map_opts = { noremap = true, silent = true }
-- Escape the Terminal mode
map('t', '<Esc>', '<C-\\><C-n>', map_opts)

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
