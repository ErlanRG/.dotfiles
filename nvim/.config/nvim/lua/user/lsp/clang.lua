local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').clangd.setup {
    capabilities = capabilities,
    on_attach = function()
        local keymap = vim.api.nvim_buf_set_keymap
        local opts = { noremap = true, silent = true }
        keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        keymap(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        keymap(bufnr, "n", "<leader>dn", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
        keymap(bufnr, "n", "<leader>dp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        keymap(bufnr, "n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", opts)
        vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
    end,
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
}
