require("lazy").setup({
    -- Config
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- Theme
    {
      "scottmckendry/cyberdream.nvim",
      lazy = false,
      priority = 1000,
    },

    -- Completion
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'hrsh7th/vim-vsnip',

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
          json = { "clang_format" },
        },
      },
    },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        }
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
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
      end
    },

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end,
    },

    -- Terminal
    "voldikss/vim-floaterm",

    -- Markdown Preview
    {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
      ---@module 'render-markdown'
      ---@type render.md.UserConfig
      opts = {},
    }
})
