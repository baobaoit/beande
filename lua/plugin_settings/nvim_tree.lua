--[[
 ╔═══════════════════════════════════════╗
 ║ Settings for kyazdani42/nvim-tree.lua ║
 ╚═══════════════════════════════════════╝
--]]
local map = require("utils").map

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
  actions = {
    open_file = {
      -- 0 by default, closes the tree when you open a file
      quit_on_open = true
    }
  },
  renderer = {
    indent_markers = {
      -- 0 by default, this option shows indent markers when folders are open
      enable = true
    },
    -- 0 by default, compact folders that only contain a single folder into one node in the file tree
    group_empty = true
  }
}

map("n", "<C-b>", ":NvimTreeToggle<CR>")
map("n", "<Leader>n", ":NvimTreeFindFile<CR>")
map("n", "<Leader>r", ":NvimTreeRefresh<CR>")

-- a list of groups can be found at `:help nvim_tree_highlight`
-- cmd[[au VimEnter * highlight NvimTreeFolderIcon guibg=blue]]
