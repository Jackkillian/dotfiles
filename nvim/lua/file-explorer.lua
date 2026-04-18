vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function custom_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.set('n', 'v', api.node.open.vertical,   opts('Open: Vertical Split'))
    vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', '?', api.tree.toggle_help,     opts('Help'))
end

require("nvim-tree").setup({
    on_attach = custom_on_attach,
    view = {
        width = 30,
    },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
    }
})

local function open_nvim_tree(data)
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
        return
    end

    vim.cmd.cd(data.file)

    require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({"VimEnter"}, { callback = open_nvim_tree })


