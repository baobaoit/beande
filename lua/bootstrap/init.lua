local M = {}

local cmd = vim.cmd
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  M.packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  cmd [[packadd packer.nvim]]
end

local home = os.getenv('HOME')
local nvim_bin_dir = home .. '/.config/nvim/bin'
local platform = require('mason-core.platform')
vim.env.PATH = nvim_bin_dir .. platform.path_sep .. vim.env.PATH

return M
