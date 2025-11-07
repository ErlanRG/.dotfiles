-- Autocompletion
return {
    'saghen/blink.cmp',
    event = { 'BufReadPre', 'BufNewFile' },
    version = '1.*',
    dependencies = {
        -- Snippet Engine
        {
            'L3MON4D3/LuaSnip',
            version = '2.*',
            build = (function()
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
            dependencies = {
                {
                    'rafamadriz/friendly-snippets',
                    config = function()
                        require('luasnip.loaders.from_vscode').lazy_load()
                    end,
                },
            },
            opts = {},
        },
        'folke/lazydev.nvim',
    },
    opts = {
        keymap = {
            -- See :h blink-cmp-config-keymap
            preset = 'enter',

            -- NOTE: For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
            --       https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            ['<C-d>'] = { 'show', 'show_documentation', 'hide_documentation' },
            -- ['<C-K>'] = { 'show_signature', 'hide_signature', 'fallback' },
            ['<C-k>'] = { 'select_prev', 'fallback' },
            ['<C-j>'] = { 'select_next', 'fallback' },
        },
        appearance = {
            nerd_font_variant = 'mono',
        },
        completion = {
            menu = {
                border = 'single',
                draw = {
                    padding = { 0, 1 }, -- padding only on right side
                    components = {
                        kind_icon = {
                            text = function(ctx)
                                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                                return kind_icon
                            end,
                            highlight = function(ctx)
                                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                return hl
                            end,
                        },
                        kind = {
                            highlight = function(ctx)
                                local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                                return hl
                            end,
                        },
                    },
                },
            },
            documentation = {
                window = { border = 'single' },
                auto_show = true,
                auto_show_delay_ms = 500,
            },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
            providers = {
                lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
            },
        },
        snippets = { preset = 'luasnip' },
        -- See :h blink-cmp-config-fuzzy for more information
        fuzzy = {
            implementation = 'prefer_rust_with_warning',
            sorts = {
                'exact',
                'score',
                'sort_text',
            },
        },
        -- Shows a signature help window while you type arguments for a function
        signature = { enabled = true },
    },
}
