-- Main LSP Configuration
return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        { 'mason-org/mason-lspconfig.nvim', opts = {} },
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        { 'j-hui/fidget.nvim', opts = {} },

        -- Allows extra capabilities provided by blink.cmp
        'saghen/blink.cmp',
    },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end


                -- stylua: ignore start
                map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
                map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
                map('gO', function() Snacks.picker.lsp_symbols() end, 'LSP Symbols')
                map('gW', function() Snacks.picker.lsp_workspace_symbols() end, 'LSP Workspace Symbols')
                map('grD', function() Snacks.picker.lsp_declarations() end, '[G]oto [D]eclaration')
                map('grd', function() Snacks.picker.lsp_definitions() end, '[G]oto [D]efinition')
                map('gri', function() Snacks.picker.lsp_implementations() end, '[G]oto [I]mplementation')
                map('grr', function() Snacks.picker.lsp_references() end, '[G]oto [R]eferences')
                map('grt', function() Snacks.picker.lsp_type_definitions() end, '[G]oto T[y]pe Definition')
                -- stylua: ignore end

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client:supports_method('textDocument/documentHighlight', event.buf) then
                    local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        buffer = event.buf,
                        group = highlight_augroup,
                        callback = vim.lsp.buf.clear_references,
                    })

                    vim.api.nvim_create_autocmd('LspDetach', {
                        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
                        callback = function(event2)
                            vim.lsp.buf.clear_references()
                            vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
                        end,
                    })
                end

                -- The following code creates a keymap to toggle inlay hints in your
                -- code, if the language server you are using supports them
                if client and client:supports_method('textDocument/inlayHint', event.buf) then
                    map('<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
                    end, '[T]oggle Inlay [H]ints')
                end
            end,
        })

        -- local capabilities = require('blink.cmp').get_lsp_capabilities()
        local server_cfg = require 'rangeler.plugins.custom.servers_config'

        local servers = {
            bashls = {},
            clangd = server_cfg.clangd,
            lua_ls = server_cfg.lua_ls,
            texlab = {},
        }

        -- Ensure the servers and tools above are installed
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
            'lua_ls', -- Lua Language server
            'stylua', -- Used to format Lua code
        })

        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        for name, server in pairs(servers) do
            -- server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            vim.lsp.config(name, server)
            vim.lsp.enable(name)
        end
    end,
}
