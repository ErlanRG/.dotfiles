local dash_opts = require 'rangeler.plugins.snacks.dashboard'
local indent_opts = require 'rangeler.plugins.snacks.indent'

-- Collection of various small independent plugins/modules
return {
    {
        'echasnovski/mini.nvim',
        config = function()
            -- Better Around/Inside textobjects
            --
            -- Examples:
            --  - va)  - [V]isually select [A]round [)]paren
            --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
            --  - ci'  - [C]hange [I]nside [']quote
            require('mini.ai').setup { n_lines = 500 }
        end,
    },

    -- Snacks
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        keys = {
            {
                '<leader>;',
                function()
                    Snacks.dashboard()
                end,
            },
            {
                '<leader>bd',
                function()
                    Snacks.bufdelete()
                end,
                desc = '[B]uffer [D]elete',
            },
            {
                '<leader>og',
                function()
                    Snacks.lazygit()
                end,
                desc = '[O]pen Lazy[G]it',
            },
            {
                '<leader>os',
                function()
                    Snacks.scratch()
                end,
                desc = '[O]pen [S]cratch',
            },
            {
                '<leader>oss',
                function()
                    Snacks.scratch.select()
                end,
                desc = '[O]pen [S]elect [S]cratch',
            },
            {
                '<leader>on',
                function()
                    Snacks.notifier.show_history()
                end,
                desc = '[O]pen [N]otifications',
            },
        },
        opts = {
            bigfile = { enabled = true },
            dashboard = dash_opts,
            indent = indent_opts,
            input = { enabled = true },
            notifier = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
        },
    },
}
