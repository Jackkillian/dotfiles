vim.opt.termguicolors = true

-- Window Borders
vim.o.winborder = "rounded"
vim.diagnostic.config({
  update_in_insert = true,
  float = {
    border = "rounded", -- Options: "single", "double", "rounded", "solid", "shadow"
  },
})

-- Theme
require('onedark').setup {
    style = 'warm'
}
require('onedark').load()


-- Lualine status bar
require('lualine').setup({
  options = {
    theme = "onedark", 
  },
})

