local handlers = require("rangeler.lsp.handlers")

-- this connects to the server
require'lspconfig'.bashls.setup {
  capabilities = handlers.capabilities,
  on_attach = handlers.on_attach,
}