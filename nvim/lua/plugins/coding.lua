return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
		keys = {
			{
				"<C-p>",
				function()
					if require("luasnip").expand_or_jumpable() then
						require("luasnip").expand_or_jump()
					end
				end,
				mode = { "i", "s" },
				desc = "Snippet Jump Forward",
			},
			{
				"<C-o>",
				function()
					if require("luasnip").jumpable(-1) then
						require("luasnip").jump(-1)
					end
				end,
				mode = { "i", "s" },
				desc = "Snippet Jump Backward",
			},
		},
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("neogen").setup({
				enabled = true,
				snippet_engine = "luasnip",
			})
		end,
		keys = {
			{
				"<leader>cc",
				function()
					require("neogen").generate()
				end,
				desc = "Generate Annotations (JSDoc)",
			},
			{
				"<leader>cf",
				function()
					require("neogen").generate({ type = "func" })
				end,
				desc = "Generate JSDoc for Function",
			},
		},
	},
}
