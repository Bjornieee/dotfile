vim.cmd("set expandtab")
vim.cmd("set tabstop=4")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = { "gbprod/nord.nvim",
    lazy = false,
    name = "nord",
    priority = 1000 }
local opts = {}

require("lazy").setup(plugins, opts)
vim.cmd.colorscheme("nord")