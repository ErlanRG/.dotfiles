-- Add indentation guides even on blank lines
return {
    {
        'lukas-reineke/indent-blankline.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = 'ibl',
        opts = {
            exclude = {
                buftypes = {
                    'terminal',
                    'nofile',
                },
                filetypes = {
                    'help',
                    'startify',
                    'dashboard',
                    'lazy',
                    'neogitstatus',
                    'NvimTree',
                    'Trouble',
                },
            },
        },
    },
}
