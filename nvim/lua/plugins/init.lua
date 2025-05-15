return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require "nvchad.configs.lspconfig"
            require "configs.lspconfig"
        end, -- Override to setup mason-lspconfig
    },

    -- override plugin configs
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- lua stuff
                "lua-language-server",
                "stylua",

                -- c/cpp stuff
                "clangd",
                "clang-format",

                -- python
                "pyright@1.1.351", -- newer versions have node skill issue
                "autopep8",

                -- latex/markdown stuff
                "ltex-ls",
                "bibtex-tidy",

                -- shell
                "shellcheck",

                -- Hyprlang
                "hyrpls",

                -- hdl
                "rust_hdl",
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "html",
                "css",
                "c",
                "cpp",
                "markdown",
                "markdown_inline",
                "yaml",
                "python",
                "latex",
                "vhdl",
                "hyprlang",
            },
            indent = {
                enable = true,
                -- disable = {
                --     "python"
                -- },
            },
        },
    },

    {
        "nvim-tree/nvim-tree.lua",
        opts = {
            git = {
                enable = true,
            },
            renderer = {
                highlight_git = true,
                icons = {
                    show = {
                        git = true,
                    },
                },
            },
        },
    },

    {
        "stevearc/conform.nvim",
        -- for users those who want auto-save conform + lazyloading!
        event = "BufWritePre",
        config = function()
            require "configs.conform"
        end,
    },

    {
        "godlygeek/tabular",
        -- ft = "vhdl", -- temporary solution, but I only need it for vhdl. To be replaced with a real formatter long-term
        cmd = { "GTabularize", "Tabularize" },
    },

    {
        "benlubas/molten-nvim",
        -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_use_border_highlights = true
        end,
        -- lazy = false
    },
    {
        -- see the image.nvim readme for more information about configuring this plugin
        "3rd/image.nvim",
        opts = {
            backend = "kitty", -- whatever backend you would like to use
            max_width = 100,
            max_height = 12,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    only_render_image_at_cursor_mode = "popup",
                    floating_windows = false, -- if true, images will be rendered in floating markdown windows
                    filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
                },
            }, -- do whatever you want with image.nvim's integrations
        },
    }
}
