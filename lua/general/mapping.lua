--[[
 ╔════════════════════════════╗
 ║ General mapping for Neovim ║
 ╚════════════════════════════╝
-- ]]
local map = require'utils'.map

--[[
 ╔══════════╗
 ║ Terminal ║
 ╚══════════╝
-- ]]
map('t', '<Esc>', '<C-\\><C-n>') -- Escape the Terminal mode


--[[
 ╔═══════════════╗
 ║ Tab in normal ║
 ╚═══════════════╝
-- ]]
map('n', '<Tab>', ':bn<CR>') -- Tab to next buffer
map('n', '<S-Tab>', ':bp<CR>') -- Shift-Tab to previous buffer

--[[
 ╔═══════╗
 ║ Save  ║
 ╚═══════╝
-- ]]
map('n', '<C-s>', ':w<CR>', {silent = false})
