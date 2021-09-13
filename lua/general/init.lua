--[[
 ╔═════════════════════════════╗
 ║ General settings for Neovim ║
 ╚═════════════════════════════╝
-- ]]
local o = vim.o
local bo = vim.bo
local wo = vim.wo
local go = vim.go
local cmd = vim.cmd

o['hidden']=true -- Required to keep multiple buffers open multiple buffers
cmd[[set nowrap]] -- Display long lines as just one line
o['mouse']='a' -- Enable your mouse
go['splitbelow']=true -- Horizontal splits will automatically be below
go['splitright']=true -- Vertical splits will automatically be to the right
cmd[[set t_Co=256]] -- Support 256 colors
bo['tabstop']=2 -- Insert 2 spaces for a tab
bo['shiftwidth']=2 -- Change the number of space characters inserted for indentation
bo['expandtab']=true -- Converts tabs to spaces
bo['smartindent']=true -- Makes indenting smart
wo['number']=true -- Line numbers
o['updatetime']=300 -- Faster completion
o['timeoutlen']=500 -- By default timeoutlen is 1000 ms
cmd[[set path+=**]]
o['termguicolors']=true -- True color support
o['wildmode']='list:longest' -- Command-line completion mode

--[[
 ╔════════════════════════╗
 ║ Key mapping for Neovim ║
 ╚════════════════════════╝
-- ]]
require'general.mapping'
