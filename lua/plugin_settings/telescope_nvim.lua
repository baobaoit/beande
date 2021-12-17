--[[
 ╔════════════════════════════════════════════╗
 ║ Settings for nvim-telescope/telescope.nvim ║
 ╚════════════════════════════════════════════╝
--]]
local telescope = require("telescope")
local telescopeThemes = require("telescope.themes")
telescope.setup {
  extensions = {
    lsp_handlers = {
      code_action = {
        telescope = telescopeThemes.get_dropdown({}),
      }
    },
    ["ui-select"] = {
      telescopeThemes.get_dropdown({})
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("fzf")
telescope.load_extension("lsp_handlers")
telescope.load_extension("ui-select")

local map = require("utils").map

map("n", "<Leader>ff", ":lua require('telescope.builtin').find_files()<CR>")
map("n", "<Leader>fg", ":lua require('telescope.builtin').live_grep()<CR>")
map("n", "<Leader>fb", ":lua require('telescope.builtin').buffers()<CR>")
map("n", "<Leader>fh", ":lua require('telescope.builtin').help_tags()<CR>")
