require("nvim-treesitter.config").setup({
    ensure_installed = {"javascript", "python", "cpp"},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
})
