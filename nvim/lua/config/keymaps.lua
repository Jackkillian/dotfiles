local map = vim.keymap.set

-- LSP
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Native Code Actions" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- Window Navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move focus to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move focus to right window" })

-- Snacks
map({ "n", "t" }, "<C-/>", function()
	Snacks.terminal.toggle()
end, { desc = "Toggle Terminal" })
map({ "n", "t" }, "<C-k>", function()
	Snacks.terminal.toggle("spotatui", {
		win = {
			position = "float",
			width = 0.8,
			height = 0.8,
			border = "rounded",
			title = " Spotatui ",
			title_pos = "center",
		},
	})
end, { desc = "Toggle spotatui" })

-- Explorer
map("n", "<C-n>", function()
	Snacks.explorer()
end, { desc = "File Explorer" })

-- Pickers
map("n", "<leader><space>", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })
map("n", "<leader>ff", function()
	Snacks.picker.files()
end, { desc = "Find Files" })
map("n", "<leader>fg", function()
	Snacks.picker.grep()
end, { desc = "Grep (Live Search)" })
map("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
map("n", "<leader>fh", function()
	Snacks.picker.help()
end, { desc = "Help Tags" })
map("n", "<leader>fk", function()
	Snacks.picker.keymaps()
end, { desc = "Keymaps" })
map("n", "<leader>fr", function()
	Snacks.picker.recent()
end, { desc = "Recent Files" })

-- Git
map("n", "<leader>gc", function()
	Snacks.picker.git_log()
end, { desc = "Git Commits" })
map("n", "<leader>gs", function()
	Snacks.picker.git_status()
end, { desc = "Git Status" })

-- LSP
map("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })
map("n", "gr", function()
	Snacks.picker.lsp_references()
end, { desc = "References" })
map("n", "gI", function()
	Snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })
map("n", "<leader>ss", function()
	Snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })
