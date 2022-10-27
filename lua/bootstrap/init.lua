local M = {}

local impatient_ok, _ = pcall(require, 'impatient')
if not impatient_ok then
  print('The plugin [impatient] not found. Please run :PackerSync!')
end

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
local platform_ok, platform = pcall(require, 'mason-core.platform')
if not platform_ok then
  platform = { path_sep = '/'  }
end
---@diagnostic disable-next-line: 122
vim.env.PATH = nvim_bin_dir .. platform.path_sep .. vim.env.PATH

return M
