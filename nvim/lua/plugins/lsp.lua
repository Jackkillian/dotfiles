return {
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local capabilities = cmp_nvim_lsp.default_capabilities()

			-- Python Setup
			vim.lsp.config("ruff", {})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp_attach_format_ruff", { clear = true }),
				callback = function(args)
					if vim.bo[args.buf].filetype == "python" then
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						if client and client.name == "ruff" then
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = args.buf,
								callback = function()
									vim.lsp.buf.format()
								end,
							})
						end
					end
				end,
			})
			vim.lsp.config("basedpyright", {
				settings = {
					basedpyright = {
						analysis = {
							diagnosticMode = "openFilesOnly",
							typeCheckingMode = "basic",
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			-- JavaScript/TypeScript Setup
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
			})
			vim.lsp.config("eslint", {
				capabilities = capabilities,
				settings = {
					format = true,
				},
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								id = client.id,
								async = false,
							})
						end,
					})
				end,
			})

			-- C/C++ Setup
			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--completion-style=detailed",
				},
				init_options = {
					fallbackFlags = {
						"-std=c++23",
					},
				},
			})

			-- Rust Setup
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						check = {
							command = "clippy",
						},
					},
				},
			})

			-- Mason
			require("mason-lspconfig").setup({
				ensure_installed = { "clangd", "ts_ls", "eslint", "rust_analyzer", "ruff", "basedpyright" },
			})
		end,
	},
}
