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
vim.lsp.enable("basedpyright")
