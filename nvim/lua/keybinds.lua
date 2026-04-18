-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy search in current buffer' })

-- LSP
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Native Code Actions' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP Rename' })

-- Theme Toggle
vim.api.nvim_set_keymap("n", "<leader>tt", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true })

-- File Explorer
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })

-- Window Navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to right window' })

-- Floating Terminal: Redirect :! to :FloatermNew
vim.keymap.set('c', '!', function()
  local cmdline = vim.fn.getcmdline()
  local cmdtype = vim.fn.getcmdtype()
  
  if cmdtype == ':' and cmdline == '' then
    return 'FloatermNew '
  else
    return '!'
  end
end, { expr = true, replace_keycodes = false })
