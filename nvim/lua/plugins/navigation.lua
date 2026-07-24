return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			require("telescope").setup({})
			pcall(require("telescope").load_extension, "fzf")
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			terminal = {
				win = {
					style = "float", -- NOTE: can also use "terminal"
				},
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
