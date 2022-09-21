local handlers = require("rangeler.lsp.handlers")

-- this connects to the server
require'lspconfig'.clangd.setup {
  filetypes = { "c", "cpp", "objc", "objcpp" },
  capabilities = handlers.capabilities,
  on_attach = handlers.on_attach,
}
