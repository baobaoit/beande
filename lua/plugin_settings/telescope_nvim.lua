--[[
 ╔════════════════════════════════════════════╗
 ║ Settings for nvim-telescope/telescope.nvim ║
 ╚════════════════════════════════════════════╝
--]]
local map = require'utils'.map

map('n', '<Leader>ff', ':lua require(\'telescope.builtin\').find_files()<CR>')
map('n', '<Leader>fg', ':lua require(\'telescope.builtin\').live_grep()<CR>')
map('n', '<Leader>fb', ':lua require(\'telescope.builtin\').buffers()<CR>')
map('n', '<Leader>fh', ':lua require(\'telescope.builtin\').help_tags()<CR>')
