-- Flash highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ highlight_group = "IncSearch", timeout = 200 })
	end,
})

-- Restore cursor on file reopen
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("LastPosition", { clear = true }),
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Close utility windows by pressing "q"
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("CloseWithQ", { clear = true }),
	pattern = { "help", "man", "qf", "lspinfo", "checkhealth" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
	end,
})

-- Auto vim resize on terminal window resize
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("ResizeSplits", { clear = true }),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})
