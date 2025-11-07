return {
    -- 'folke/tokyonight.nvim',
    -- 'philosofonusus/morta.nvim',
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
        vim.cmd.colorscheme 'catppuccin'
    end,
}
