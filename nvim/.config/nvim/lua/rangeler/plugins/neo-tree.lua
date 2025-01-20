-- Neo-tree
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-tree/nvim-web-devicons', lazy = true }, -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
        { '<leader>oe', ':Neotree toggle<CR>', desc = '[E]xplorer', silent = true },
    },
    opts = {
        filesystem = {
            window = {
                mappings = {
                    ['<leader>oe'] = 'close_window',
                },
            },
        },
    },
}
