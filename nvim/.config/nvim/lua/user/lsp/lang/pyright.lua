local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

local setup = require("user.lsp.settings").setup()
local pyright_opts = require("user.lsp.settings")

lspconfig.pyright.setup{
    on_attach = pyright_opts.keymaps,
    capabilities = pyright_opts.capabilities,
}
