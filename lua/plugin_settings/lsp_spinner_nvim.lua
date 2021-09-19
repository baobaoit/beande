--[[
 ╔═════════════════════════════════════╗
 ║ Settings for doums/lsp_spinner.nvim ║
 ╚═════════════════════════════════════╝
--]]
-- register an handler for `$/progress` method
-- options are optional
require("lsp_spinner").setup {
  spinner = {'⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'},
  interval = 80, -- spinner frame rate in ms
  redraw_rate = 50, -- statusline refresh rate in ms
}
