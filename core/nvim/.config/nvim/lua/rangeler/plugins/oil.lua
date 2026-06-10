return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    keys = {
        { '<leader>oe', '<cmd>Oil --float<cr>', { desc = '[O]pen [E]xplorer' } },
        { '<leader>.', '<cmd>Oil --float<cr>', { desc = '[O]pen [E]xplorer' } },
    },
    opts = {
        columns = {
            'icon',
            'permissions',
            'size',
            'mtime',
        },
        view_options = {
            show_hidden = true,
            is_hidden_file = function(name, bufnr)
                local m = name:match '^%.'
                return m ~= nil
            end,
            is_always_hidden = function(name, bufnr)
                return false
            end,
            natural_order = 'fast',
            case_insensitive = false,
            sort = {
                { 'type', 'asc' },
                { 'name', 'asc' },
            },
        },
        float = {
            border = 'rounded',
            padding = 2,
            preview_split = 'below',
            win_options = {
                winblend = 10,
            },
        },
        preview = {
            border = 'rounded',
            win_options = {
                winblend = 0,
            },
        },
        keymaps = {
            ['<BS>'] = 'actions.parent',
            ['-'] = 'actions.parent',
            ['h'] = 'actions.parent',
            ['l'] = 'actions.select',
            ['q'] = 'actions.close',
            ['.'] = 'actions.toggle_hidden',
            ['c'] = 'actions.copy_to_system_clipboard',
            ['p'] = { 'actions.paste_from_system_clipboard', desc = 'Copy from clipboard' },
            ['P'] = {
                callback = function()
                    require('oil.actions').paste_from_system_clipboard { delete_original = true }
                end,
                desc = 'Move from clipboard',
            },
            ['R'] = 'actions.refresh',
        },
    },
}
