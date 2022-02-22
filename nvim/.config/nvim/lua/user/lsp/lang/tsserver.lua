local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

local setup = require("user.lsp.settings").setup()
local tsserver_opts = require("user.lsp.settings")

lspconfig.tsserver.setup{
    on_attach = tsserver_opts.keymaps,
    capabilities = tsserver_opts.capabilities,
}
