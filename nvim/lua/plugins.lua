require("lazy").setup({
	-- LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

	-- Theme
	{
		"uhs-robert/oasis.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("oasis").setup({ style = "lagoon" })
			vim.cmd.colorscheme("oasis")
		end,
	},

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		commit = "ae644feb7b67bf1ce4260c231d1d4300b19c6f30",
		pin = true,
	},
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-buffer",
	"hrsh7th/vim-vsnip",

	-- Formatting
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = false,
			},
			formatters_by_ft = {
				c = { "clang_format" },
				cpp = { "clang_format" },
				json = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				astro = { "prettierd", "prettier", stop_after_first = true },
				lua = { "stylua" },
				rust = { "rustfmt" },
			},
		},
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "master",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "javascript", "lua", "python", "cpp", "css", "html", "rust" },
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
				},
			})
		end,
	},

	-- Telescope
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

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},

	-- Terminal
	"voldikss/vim-floaterm",

	-- Markdown Preview
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},

	-- Git
	"lewis6991/gitsigns.nvim",

	-- Annotations
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

	-- Image display
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
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

	-- Spotify controller
	-- init = function()
	-- 	-- Optional mappings.
	-- 	vim.keymap.set("n", "<leader>ss", ":Spotify play/pause<CR>", { silent = true })
	-- 	vim.keymap.set("n", "<leader>sj", ":Spotify next<CR>", { silent = true })
	-- 	vim.keymap.set("n", "<leader>sk", ":Spotify prev<CR>", { silent = true })
	-- 	vim.keymap.set("n", "<leader>so", ":Spotify show<CR>", { silent = true })
	-- 	vim.keymap.set("n", "<leader>sc", ":Spotify status<CR>", { silent = true })
	-- end,
	{
		"iamt4nk/smm.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = {
			premium = true,
			icons = true,
			playback = {
				timer_update_interval = 250,
				timer_sync_interval = 5000,
				playback_pos = "TopRight",
				playback_width = 30,
				progress_bar_width = 25,
				song_links = false,
			},
			spotify = {
				api_retry_max = 3,
				api_retry_backoff = 2000,
				auth = {
					client_id = vim.env.SPOTIFY_CLIENT_ID,
					callback_url = "http://127.0.0.1",
					callback_port = "8000",
				},
			},
		},
	},

	"rust-lang/rust.vim",
})
