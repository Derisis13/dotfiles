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
      },
      indent = {
        enable = true,
        -- disable = {
        --   "python"
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
    --  for users those who want auto-save conform + lazyloading!
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "godlygeek/tabular",
    -- ft = "vhdl", -- temporary solution, but I only need it for vhdl. To be replaced with a real formatter long-term
    cmd = { "GTabularize", "Tabularize" },
    -- lazy = false
  },
}
