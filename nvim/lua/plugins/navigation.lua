return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = {
				enabled = true,
				preset = {
					keys = {
						{ icon = " ", key = "u", desc = "Update", action = ":Lazy update" },
						{ icon = "󰈞 ", key = "f", desc = "Files", action = ":lua Snacks.dashboard.pick('files')" },
						{
							icon = "⚙ ",
							key = "b",
							desc = "Builtins",
							action = ":lua Snacks.dashboard.pick('pickers')",
						},
						{
							icon = " ",
							key = "k",
							desc = "Keymaps",
							action = ":lua Snacks.dashboard.pick('keymaps')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "recent_files", title = "Recent Files", limit = 10, padding = 1 },
					{ section = "projects", title = "Projects", limit = 8, padding = 1 },
					{ section = "startup" },
				},
			},
			terminal = {
				win = {
					style = "float", -- NOTE: can also use "terminal"
				},
			},
			picker = {
				enabled = true,
				opts = {
					hidden = true,
					ignored = false,
				},
				sources = {
					explorer = {
						hidden = true,
						ignored = false,
					},
				},
				layout = {
					preset = "default", -- Options: "default", "vertical", "dropdown", etc.
				},
				win = {
					input = {
						keys = {
							["<C-n>"] = { "close", mode = { "n", "i" } },
						},
					},
					list = {
						keys = {
							["<C-n>"] = { "close", mode = { "n", "i" } },
						},
					},
				},
			},
			explorer = {
				enabled = true,
				replace_netrw = true,
			},
			image = {
				enabled = true,
				doc = {
					inline = true,
					float = true,
				},
				resolve = function(file, src)
					local data_start = src:find("data:image/")
					if data_start then
						local data_uri = src:sub(data_start)
						local base64_data = data_uri:match(",(.*)$")

						if base64_data then
							--            base64_data = base64_data:gsub("[%s`']", "")
							base64_data = base64_data:gsub("[^%w%+%/%=]", "")

							local status, decoded = pcall(vim.base64.decode, base64_data)
							if not status then
								return nil
							end

							local ext = "png"
							if data_uri:match("data:image/[^;]*svg") then
								ext = "svg"
							end

							local cache_dir = vim.fn.stdpath("cache") .. "/snacks_uri_cache"
							vim.fn.mkdir(cache_dir, "p")

							local filename = "img_" .. vim.fn.sha256(base64_data):sub(1, 10) .. "." .. ext
							local tmp_path = cache_dir .. "/" .. filename

							if vim.fn.filereadable(tmp_path) == 0 then
								local f = io.open(tmp_path, "wb")
								if f then
									f:write(decoded)
									f:close()
								end
							end

							return tmp_path
						end
					end
					return nil
				end,
			},
		},
	},
}
