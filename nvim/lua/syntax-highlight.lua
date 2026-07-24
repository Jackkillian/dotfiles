require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "typescript", "lua", "python", "cpp", "rust" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
})
