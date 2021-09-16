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
 ╔═══════╗
 ║ Save  ║
 ╚═══════╝
--]]
map('n', '<C-s>', ':w<CR>', {silent = false})
map('i', '<C-s>', '<Esc>:w<CR>', {silent = false})
map('n', '<C-S-s>', ':wa<CR>', {silent = false})
map('i', '<C-S-s>', '<Esc>:wa<CR>', {silent = false})
