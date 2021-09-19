--[[
 ╔═══════════════════════════════════════╗
 ║ Settings for kyazdani42/nvim-tree.lua ║
 ╚═══════════════════════════════════════╝
--]]
local g = vim.g
local map = require("utils").map

-- 0 by default, opens the tree when typing `vim $DIR` or `vim`
g.nvim_tree_auto_open = 1

-- 0 by default, this option allows the cursor to be updated when entering a buffer
g.nvim_tree_follow = 1

-- 0 by default, will update the path of the current dir if the file is not inside the tree.
g.nvim_tree_follow_update_path = 1

-- 0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_group_empty = 1

-- 0 by default, this option hides files and folders starting with a dot `.`
g.nvim_tree_hide_dotfiles = 1

-- 0 by default, this option shows indent markers when folders are open
g.nvim_tree_indent_markers = 1

-- 0 by default, closes the tree when you open a file
g.nvim_tree_quit_on_open = 1

map("n", "<C-b>", ":NvimTreeToggle<CR>")
map("n", "<Leader>n", ":NvimTreeFindFile<CR>")
map("n", "<Leader>r", ":NvimTreeRefresh<CR>")

-- a list of groups can be found at `:help nvim_tree_highlight`
-- cmd[[au VimEnter * highlight NvimTreeFolderIcon guibg=blue]]
