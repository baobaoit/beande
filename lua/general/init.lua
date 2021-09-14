--[[
 ╔═════════════════════════════╗
 ║ General settings for Neovim ║
 ╚═════════════════════════════╝
--]]
local cmd = vim.cmd
local go = vim.go
local o = vim.o
local wo = vim.wo

cmd[[filetype plugin indent on]]
cmd[[set nowrap]] -- Display long lines as just one line
cmd[[set path+=**]]
cmd[[set t_Co=256]] -- Support 256 colors
go['splitbelow'] = true -- Horizontal splits will automatically be below
go['splitright'] = true -- Vertical splits will automatically be to the right
o['hidden'] = true -- Required to keep multiple buffers open multiple buffers
o['mouse'] = 'a' -- Enable your mouse
o['termguicolors'] = true -- True color support
o['timeoutlen'] = 500 -- By default timeoutlen is 1000 ms
o['updatetime'] = 300 -- Faster completion
o['wildmode'] = 'list:longest' -- Command-line completion mode
wo['number'] = true -- Line numbers

--[[
 ╔════════════════════════╗
 ║ Key mapping for Neovim ║
 ╚════════════════════════╝
--]]
require'general.mapping'

--[[
 ╔═════════════════════╗
 ║ Augroups for Neovim ║
 ╚═════════════════════╝
--]]
require'utils'.augroups {
  DisableAutomaticCommentInNewLine = {
    'FileType * setlocal formatoptions-=cro'
  },
  SetTab = {
    'FileType * setlocal expandtab shiftwidth=2 tabstop=2 smartindent'
  }
}
