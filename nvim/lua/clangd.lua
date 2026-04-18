vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed"
    },
    init_options = {
        fallbackFlags = {
           "-std=c++23"
        }
    },
})
vim.lsp.enable("clangd")
