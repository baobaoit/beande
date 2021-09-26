--[[
 ╔════════════════════════════╗
 ║ General mapping for Neovim ║
 ╚════════════════════════════╝
--]]
local map = require('utils').map

--[[
 ╔══════════╗
 ║ Terminal ║
 ╚══════════╝
--]]
map('t', '<Esc>', '<C-\\><C-n>') -- Escape the Terminal mode


--[[
 ╔═══════════════╗
 ║ Tab in normal ║
 ╚═══════════════╝
--]]
map('n', '<S-Tab>', ':bp<CR>') -- Shift-Tab to previous buffer
map('n', '<Tab>', ':bn<CR>') -- Tab to next buffer

--[[
 ╔═══════════════════════════════╗
 ║ Switch Neovim's tab in normal ║
 ╚═══════════════════════════════╝
--]]
map('n', '<Space>h', 'gT') -- Shift-Tab to previous buffer
map('n', '<Space>l', 'gt') -- Tab to next buffer

--[[
 ╔════════════════╗
 ║ Save and quit  ║
 ╚════════════════╝
--]]
map('n', '<C-s>', ':w<CR>', {silent = false})
map('i', '<C-s>', '<Esc>:w<CR>', {silent = false})
map('n', '<C-q>', ':q<CR>', {silent = false})
map('i', '<C-q>', '<Esc>:q<CR>', {silent = false})

--[[
 ╔════════════════════════╗
 ║ Switch Neovim's window ║
 ╚════════════════════════╝
--]]
map('n', '<M-j>', '<C-w>j')
map('n', '<M-k>', '<C-w>k')
map('n', '<M-h>', '<C-w>h')
map('n', '<M-l>', '<C-w>l')
