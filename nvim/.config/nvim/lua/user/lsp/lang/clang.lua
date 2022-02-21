local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

local setup = require("user.lsp.settings").setup()
local clangd_opts = require("user.lsp.settings")

lspconfig.clangd.setup{
    on_attach = clangd_opts.keymaps,
    capabilities = clangd_opts.capabilities,
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
}
