--[[
 ╔═══════════════════════════════════╗
 ║ Settings for rcarriga/nvim-dap-ui ║
 ╚═══════════════════════════════════╝
--]]
local dapui = require "dapui"
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  -- tray = {
  --   elements = { "repl" },
  --   size = 10,
  --   position = "bottom", -- Can be "left", "right", "top", "bottom"
  -- },
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

local map = require("utils").map

map("n", "<Leader>dt", ":lua require('dapui').toggle()<CR>")
map("n", "<Leader>de", ":lua require('dapui').eval()<CR>")
map("v", "<Leader>de", ":lua require('dapui').eval()<CR>")

-- Replicated auto-open behavior.
local dap = require('dap')
dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
