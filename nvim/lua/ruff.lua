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

vim.lsp.enable("ruff")
