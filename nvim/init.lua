vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
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

