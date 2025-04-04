-- Autocompletion
return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
            'L3MON4D3/LuaSnip',
            build = (function()
                -- Build Step is needed for regex support in snippets.
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
        },
        'saadparwaiz1/cmp_luasnip',

        -- Adds other completion capabilities.
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
    },
    config = function()
        -- See `:help cmp`
        local cmp = require 'cmp'
        local cmp_types = require 'cmp.types.cmp'
        local cmp_window = require 'cmp.config.window'
        local ConfirmBehavior = cmp_types.ConfirmBehavior

        local icons = require 'rangeler.utils.icons'

        local luasnip = require 'luasnip'
        luasnip.config.setup {}

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
        end

        cmp.setup {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            confirm_opts = {
                behavior = ConfirmBehavior.Replace,
                select = false,
            },
            completion = {
                completeopt = 'menu,menuone,noinsert',
                keyword_length = 1,
            },
            sources = {
                {
                    name = 'lazydev',
                    -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                    group_index = 0,
                },
                { name = 'buffer' },
                { name = 'copilot', group_index = 2 },
                { name = 'luasnip' },
                { name = 'nvim_lsp' },
                { name = 'path' },
            },
            duplicates_default = 0,
            duplicates = {
                buffer = 1,
                path = 1,
                nvim_lsp = 0,
                luasnip = 1,
            },
            window = {
                completion = cmp_window.bordered(),
                documentation = cmp_window.bordered(),
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                expandable_indicator = true,
                format = function(entry, vim_item)
                    vim_item.kind = icons.kind[vim_item.kind]
                    vim_item.menu = ({
                        nvim_lsp = '',
                        nvim_lua = '',
                        luasnip = '',
                        buffer = '',
                        path = '',
                    })[entry.source.name]
                    if entry.source.name == 'copilot' then
                        vim_item.kind = icons.kind.Copilot
                        vim_item.kind_hl_group = 'CmpItemKindCopilot'
                    end

                    if entry.source.name == 'cmp_tabnine' then
                        vim_item.kind = icons.misc.Robot
                        vim_item.kind_hl_group = 'CmpItemKindTabnine'
                    end

                    if entry.source.name == 'crates' then
                        vim_item.kind = icons.misc.Package
                        vim_item.kind_hl_group = 'CmpItemKindCrate'
                    end

                    if entry.source.name == 'lab.quick_data' then
                        vim_item.kind = icons.misc.CircuitBoard
                        vim_item.kind_hl_group = 'CmpItemKindConstant'
                    end
                    return vim_item
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
                ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
                ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
                ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
                ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
                ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
                ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                ['<C-e>'] = cmp.mapping {
                    i = cmp.mapping.abort(),
                    c = cmp.mapping.close(),
                },
                -- Accept currently selected item. If none selected, `select` first item.
                -- Set `select` to `false` to only confirm explicitly selected items.
                ['<CR>'] = cmp.mapping.confirm { select = false },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expandable() then
                        luasnip.expand()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        fallback()
                    else
                        fallback()
                    end
                end, {
                    'i',
                    's',
                }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {
                    'i',
                    's',
                }),
            },
        }
    end,
}
