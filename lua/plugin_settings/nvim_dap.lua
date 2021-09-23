--[[
 ╔════════════════════════════════════╗
 ║ Settings for mfussenegger/nvim-dap ║
 ╚════════════════════════════════════╝
--]]
local dap = require "dap"
dap.adapters.java = function(callback, _)
  require("jdtls.util").execute_command({command = "vscode.java.startDebugSession"}, function(err0, port)
    assert(not err0, vim.inspect(err0))

    callback({
      type = "server";
      host = "127.0.0.1";
      port = port;
    })
  end)
end

dap.configurations.java = {
  {
    type = "java";
    request = "attach";
    name = "Debug (Attach) - Remote";
    hostName = "127.0.0.1";
    port = 5005;
  },
}

local map = require("utils").map

map("n", "<F5>", ":lua require'dap'.continue()<CR>")
map("n", "<F10>", ":lua require'dap'.step_over()<CR>")
map("n", "<F11>", ":lua require'dap'.step_into()<CR>")
map("n", "<F12>", ":lua require'dap'.step_out()<CR>")
map("n", "<Leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
map("n", "<Leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<Leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
map("n", "<Leader>dr", ":lua require'dap'.repl.toggle()<CR>")
map("n", "<Leader>dl", ":lua require'dap'.run_last()<CR>")
