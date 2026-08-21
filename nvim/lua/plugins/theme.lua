return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			transparent_background = !vim.g.started_by_firenvim,
			float = {
				transparent = !vim.g.started_by_firenvim,
			},
		})
		vim.cmd.colorscheme("catppuccin-macchiato")
	end,
}
