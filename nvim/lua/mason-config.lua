require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "clangd", "ts_ls", "eslint", "rust_analyzer" },
})

require("lspconfig")

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config("ts_ls", {
	capabilities = capabilities,
})
vim.lsp.enable("ts_ls")

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
vim.lsp.enable("eslint")

vim.lsp.enable("clangd")

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

vim.lsp.enable("rust_analyzer")
