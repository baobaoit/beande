--[[
 ╔═══════════════════════════════════════╗
 ║ Settings for kyazdani42/nvim-tree.lua ║
 ╚═══════════════════════════════════════╝
--]]
local g = vim.g
local map = require("utils").map

-- 0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_group_empty = 1

-- 0 by default, this option shows indent markers when folders are open
g.nvim_tree_indent_markers = 1

-- 0 by default, closes the tree when you open a file
g.nvim_tree_quit_on_open = 1

require("nvim-tree").setup {
  -- open the tree when running this setup function
  open_on_setup = true,
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable = true,
  },
  filters = {
    -- 0 by default, this option hides files and folders starting with a dot `.`
    dotfiles = true,
  },
}

map("n", "<C-b>", ":NvimTreeToggle<CR>")
map("n", "<Leader>n", ":NvimTreeFindFile<CR>")
map("n", "<Leader>r", ":NvimTreeRefresh<CR>")

-- a list of groups can be found at `:help nvim_tree_highlight`
-- cmd[[au VimEnter * highlight NvimTreeFolderIcon guibg=blue]]
