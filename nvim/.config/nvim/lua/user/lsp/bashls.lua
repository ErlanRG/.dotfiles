local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['bashls'].setup {
    capabilities = capabilities,
    cmd = { "bash-language-server", "start" },
    cmd_env = {
      GLOB_PATTERN = "*@(.sh|.inc|.bash|.command)"
    },
    filetypes = { "sh" },
    single_file_support = true,
}
