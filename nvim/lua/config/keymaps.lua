local map = vim.keymap.set

-- Telescope
map("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, { desc = "Telescope find files" })
map("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, { desc = "Telescope live grep" })
map("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, { desc = "Telescope buffers" })
map("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end, { desc = "Telescope help tags" })
map("n", "<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Fuzzy search in current buffer" })
map("n", "<leader>fn", function()
	require("telescope.builtin").builtin()
end, { desc = "Telescope builtins" })
map("n", "<leader>fk", function()
	require("telescope.builtin").keymaps()
end, { desc = "Telescope keymaps" })

-- LSP
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Native Code Actions" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- File Explorer
map("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move focus to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move focus to right window" })

-- Spotify
map("n", "<leader>mm", ":Spotify <CR>", { silent = true })
map("n", "<leader>mo", ":Spotify pause<CR>", { silent = true })
map("n", "<leader>mp", ":Spotify resume<CR>", { silent = true })
map("n", "<leader>mj", ":Spotify next<CR>", { silent = true })
map("n", "<leader>mk", ":Spotify prev<CR>", { silent = true })
map("n", "<leader>md", ":Spotify select device<CR>", { silent = true })
map("n", "<leader>ms", ":Spotify shuffle<CR>", { silent = true })
map("n", "<leader>mr", ":Spotify repeat<CR>", { silent = true })

-- Snacks terminal
vim.keymap.set({ "n", "t" }, "<C-/>", function()
	Snacks.terminal.toggle()
end, { desc = "Toggle Terminal" })
-- vim.keymap.set("n", "<leader>gg", function()
-- 	Snacks.terminal.open("lazygit")
-- end, { desc = "Lazygit" })
