return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				theme = "hyper",
				config = {
					week_header = {
						enable = true,
					},
					shortcut = {
						{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Files",
							group = "Label",
							action = "Telescope find_files",
							key = "f",
						},
						{
							icon = " ",
							icon_hl = "DiagnosticHint",
							desc = "Builtins",
							group = "DiagnosticHint",
							action = "Telescope builtin",
							key = "b",
						},
						{
							icon = " ",
							icon_hl = "@variable",
							desc = "Keymaps",
							group = "Label",
							action = "Telescope keymaps",
							key = "k",
						},
					},
					project = {
						enable = true,
						limit = 8,
						action = "Telescope find_files cwd=",
					},
					mru = {
						enable = true,
						limit = 10,
					},
					footer = {},
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local function custom_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				api.config.mappings.default_on_attach(bufnr)

				vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
				vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			end

			require("nvim-tree").setup({
				on_attach = custom_on_attach,
				view = {
					width = 30,
				},
				sync_root_with_cwd = true,
				respect_buf_cwd = true,
				update_focused_file = {
					enable = true,
					update_root = true,
				},
			})

			local function open_nvim_tree(data)
				local directory = vim.fn.isdirectory(data.file) == 1

				if not directory then
					return
				end

				vim.cmd.cd(data.file)

				require("nvim-tree.api").tree.open()
			end
			vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local filename_conf = {
				"filename",
				path = 1,
				symbols = {
					modified = "*",
					readonly = "[-]",
					unnamed = "[No Name]",
					newfile = "[New]",
				},
			}

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
					lualine_x = {},
					lualine_y = { "lsp_status" },
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
					lualine_x = {},
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
				winbar = {
					lualine_a = {},
					lualine_b = { filename_conf },
					lualine_c = {},
					lualine_x = { "encoding" },
					lualine_y = { "filetype" },
					lualine_z = {},
				},
				inactive_winbar = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { filename_conf },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
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
