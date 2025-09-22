local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- if you just want default config for the servers then put them in a table
local servers = { "hyprls", "lua-language-server", "clangd", "basedpyright", "vhdl_ls" }

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
