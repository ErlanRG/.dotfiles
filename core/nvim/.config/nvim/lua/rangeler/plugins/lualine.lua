local components = require('rangeler.plugins.custom.lualine_comp').components

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
        options = {
            theme = 'auto',
            globalstatus = true,
            icons_enabled = icons,
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
            disabled_filetypes = { 'snacks_dashboard' },
        },
        sections = {
            lualine_a = {
                components.mode,
            },
            lualine_b = {
                components.branch,
                components.diff,
                components.python_env,
            },
            lualine_c = {
                '%=',
                components.filetype,
                components.filename,
            },
            lualine_x = {
                components.diagnostics,
                components.treesitter,
                components.lsp,
                components.spaces,
            },
            lualine_y = { components.location },
            lualine_z = {
                components.progress,
            },
        },
        inactive_sections = {
            lualine_a = {
                components.mode,
            },
            lualine_b = {
                components.branch,
            },
            lualine_c = {
                components.diff,
                components.python_env,
            },
            lualine_x = {
                components.diagnostics,
                components.lsp,
                components.spaces,
                components.filetype,
            },
            lualine_y = { components.location },
            lualine_z = {
                components.progress,
            },
        },
    },
}
