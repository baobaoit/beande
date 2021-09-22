--[[
 ╔════════════════════════════════════════════╗
 ║ Settings for nvim-telescope/telescope.nvim ║
 ╚════════════════════════════════════════════╝
--]]
local telescope = require("telescope")
telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "target",
      ".git",
      ".vscode",
      ".idea",
      ".settings",
      ".metadata",
      ".mvn",
      "out",
    },
  },
  extensions = {
    lsp_handlers = {
      code_action = {
        telescope = require('telescope.themes').get_dropdown({}),
      }
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')
telescope.load_extension('lsp_handlers')


local map = require("utils").map

map("n", "<Leader>ff", ":lua require('telescope.builtin').find_files()<CR>")
map("n", "<Leader>fg", ":lua require('telescope.builtin').live_grep()<CR>")
map("n", "<Leader>fb", ":lua require('telescope.builtin').buffers()<CR>")
map("n", "<Leader>fh", ":lua require('telescope.builtin').help_tags()<CR>")
