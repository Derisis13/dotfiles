local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },

    css = { "prettier" },
    html = { "prettier" },

    sh = { "shfmt" },

    python = { "autopep8" },

    latex = { "bibtex-tidy" },

    c = { "clang_format" },
    cpp = { "clang_format" },
  },

  -- adding same formatter for multiple filetypes can look too much work for some
  -- instead of the above code you could just use a loop! the config is just a table after all!

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
