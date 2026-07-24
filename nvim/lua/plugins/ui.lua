return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "oasis",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					always_show_tabline = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
						refresh_time = 16, -- ~60fps
						events = {
							"WinEnter",
							"BufEnter",
							"BufWritePost",
							"SessionLoadPost",
							"FileChangedShellPost",
							"VimResized",
							"Filetype",
							"CursorMoved",
							"CursorMovedI",
							"ModeChanged",
						},
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "diff" },
					lualine_c = { "diagnostics", "searchcount" },
					lualine_x = {
						{
							"filename",
							path = 1,
							symbols = {
								modified = "*",
								readonly = "[-]",
								unnamed = "[No Name]",
								newfile = "[New]",
							},
						},
					},
					lualine_y = { "filetype" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "diagnostics" },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {
					lualine_a = {
						{
							"windows",
							use_mode_colors = true,
							show_modified_status = true,
							symbols = {
								modified = "*",
							},
						},
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = { "lsp_status" },
					lualine_y = {
						{
							"datetime",
							style = "default",
						},
					},
					lualine_z = {
						{
							"tabs",
							use_mode_colors = true,
							mode = 2,
							symbols = {
								modified = "*",
							},
						},
					},
				},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
}
