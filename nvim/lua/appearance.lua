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
  local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
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
if vim.fn.has("mac") == 1 then
  local last_appearance = get_macos_appearance()
  local function sync_theme()
    vim.defer_fn(function()
      local appearance = get_macos_appearance()
      if appearance == last_appearance then return end
      last_appearance = appearance
      require("cyberdream").setup({
        theme = { variant = appearance },
      })
      vim.cmd.colorscheme("cyberdream")
    end, 150)
  end

  vim.api.nvim_create_autocmd("FocusGained", {
    callback = sync_theme,
  })
end

-- Lualine status bar
require('lualine').setup({
  options = {
    theme = "auto", 
  },
})

