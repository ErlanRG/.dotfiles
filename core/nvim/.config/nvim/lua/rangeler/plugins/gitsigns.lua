-- Adds git related signs to the gutter, as well as utilities for managing changes
local icons = require 'rangeler.utils.icons'

return {
    {
        'lewis6991/gitsigns.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            signs = {
                add = { text = icons.ui.BoldLineLeft },
                change = { text = icons.ui.BoldLineLeft },
                delete = { text = icons.ui.TriangleRight },
                topdelete = { text = icons.ui.TriangleRight },
                changedelete = { text = icons.ui.BoldLineLeft },
                untracked = { text = icons.ui.BoldLineLeft },
            },
            signs_staged_enable = false,
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                interval = 1000,
                follow_files = true,
            },
            attach_to_untracked = true,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
            },
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000,
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1,
            },
        },
        keys = {
            -- Navigation
            {
                ']c',
                function()
                    if vim.wo.diff then
                        vim.cmd.normal { ']c', bang = true }
                    else
                        require('gitsigns').nav_hunk 'next'
                    end
                end,
                desc = 'Jump to next git [c]hange',
            },
            {
                '[c',
                function()
                    if vim.wo.diff then
                        vim.cmd.normal { '[c', bang = true }
                    else
                        require('gitsigns').nav_hunk 'prev'
                    end
                end,
                desc = 'Jump to previous git [c]hange',
            },
            -- Actions
            -- visual mode
            {
                '<leader>gs',
                mode = 'v',
                function()
                    require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end,
                desc = '[S]tage hunk',
            },
            {
                '<leader>gr',
                mode = 'v',
                function()
                    require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end,
                desc = '[R]eset hunk',
            },
            -- normal mode
            {
                '<leader>gs',
                function()
                    require('gitsigns').stage_hunk()
                end,
                desc = '[S]tage hunk',
            },
            {
                '<leader>gr',
                function()
                    require('gitsigns').reset_hunk()
                end,
                desc = '[R]eset hunk',
            },
            {
                '<leader>gS',
                function()
                    require('gitsigns').stage_buffer()
                end,
                desc = 'Stage [B]uffer',
            },
            {
                '<leader>gu',
                function()
                    require('gitsigns').undo_stage_hunk()
                end,
                desc = '[U]ndo stage hunk',
            },
            {
                '<leader>gR',
                function()
                    require('gitsigns').reset_buffer()
                end,
                desc = '[R]eset buffer',
            },
            {
                '<leader>gp',
                function()
                    require('gitsigns').preview_hunk()
                end,
                desc = '[P]review hunk',
            },
            {
                '<leader>gd',
                function()
                    require('gitsigns').diffthis()
                end,
                desc = '[D]iff against index',
            },
            {
                '<leader>gD',
                function()
                    require('gitsigns').diffthis() '@'
                end,
                desc = '[D]iff against last commit',
            },
            -- Toggles
            {
                '<leader>tb',
                function()
                    Snacks.git.blame_line()
                end,
                desc = '[T]oggle [B]lame line',
            },
            {
                '<leader>tD',
                function()
                    require('gitsigns').preview_hunk_inline()
                end,
                desc = '[T]oggle git show [D]eleted',
            },
        },
    },
}
