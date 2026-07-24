local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.number = true

require("plugins")
require("file-explorer")
require("mason-config")
require("basedpyright")
require("ruff")
require("clangd")
require("code-completion")
require("appearance")
require("syntax-highlight")
require("terminal")
require("keybinds")
require("clipboard")
require("git")

