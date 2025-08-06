return {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
        'MunifTanjim/nui.nvim',
    },
    opts = {},
    config = function()
        local status_ok, noice = pcall(require, 'noice')
        if not status_ok then
            return
        end

        local colors = require 'catppuccin.palettes.mocha'
        vim.api.nvim_set_hl(0, 'MacroRecordingIcon', { fg = colors.red, bold = true })

        noice.setup {
            lsp = {
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
            routes = {
                {
                    view = 'cmdline',
                    filter = { event = 'msg_showmode', any = { { find = 'recording' } } },
                    opts = { format = { { ' 󰑊', hl_group = 'MacroRecordingIcon' }, ' ', '{message}' } },
                },
            },
        }
    end,
}
