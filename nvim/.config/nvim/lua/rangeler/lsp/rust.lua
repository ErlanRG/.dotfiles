local handlers = require("rangeler.lsp.handlers")

require'lspconfig'.rust_analyzer.setup({
  on_attach = handlers.on_attach,
  capabilities = handlers.capabilities,
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = "module",
      },
      prefix = "self",
    },
    cargo = {
      buildScripts = {
        enable = true,
      },
    },
    procMacro = {
      enable = true,
    },
  }
})
