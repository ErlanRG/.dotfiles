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

            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            -- require('mini.surround').setup()
        end,
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        keys = {
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
        },
    },
}
