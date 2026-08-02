local opt = vim.opt

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.softtabstop = 4

-- Search Settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- UI + Appearance
vim.opt.mouse = ""
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.splitright = false
opt.splitbelow = false
vim.o.winborder = "rounded"
vim.diagnostic.config({
	update_in_insert = true,
	float = {
		border = "rounded",
	},
})

-- Clipboard + System
-- opt.clipboard = "unnamedplus"
opt.updatetime = 250
opt.undofile = true

-- Disable netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
