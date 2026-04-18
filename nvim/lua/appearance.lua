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
local function get_macos_appearance()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  if not handle then return "dark" end
  local result = handle:read("*a")
  handle:close()
  return result:match("Dark") and "dark" or "light"
end

require("cyberdream").setup({
  variant=get_macos_appearance(),
  transparent = true,
  italic_comments = true,
  hide_fillchars = false,
  borderless_pickers = false,
  terminal_colors = true,
  extensions = {
    default = true,
  },
})
vim.cmd.colorscheme("cyberdream")

-- Sync light/dark mode with MacOS
local last_appearance = nil
local function sync_theme()
  local appearance = get_macos_appearance()
  if appearance == last_appearance then return end
  last_appearance = appearance
  require("cyberdream").setup({
    theme = { variant = appearance },
  })
  vim.cmd.colorscheme("cyberdream")
end
vim.api.nvim_create_autocmd("FocusGained", {
  callback = sync_theme,
})

-- Lualine status bar
require('lualine').setup({
  options = {
    theme = "auto", 
  },
})

