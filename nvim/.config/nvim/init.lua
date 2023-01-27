-- Lazy config
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local lazy_ok, lazy = pcall(require, "lazy")
if not lazy_ok then
  return
end

lazy.setup "plugins"

-- Core options
require "colors"
require "keymaps"
require "options"

-- Lspconfig setup
require("lspsettings").setup()
