return {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    keys = {
        { '<leader>oe', '<cmd>Oil --float<cr>', { desc = '[O]pen [E]xplorer' } },
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
            ['q'] = 'actions.close',
        },
    },
}
