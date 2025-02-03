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
                '<leader>hs',
                mode = 'v',
                function()
                    require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end,
                desc = 'git [s]tage hunk',
            },
            {
                '<leader>hr',
                mode = 'v',
                function()
                    require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end,
                desc = 'git [r]eset hunk',
            },
            -- normal mode
            {
                '<leader>hs',
                function()
                    require('gitsigns').stage_hunk()
                end,
                desc = 'git [s]tage hunk',
            },
            {
                '<leader>hr',
                function()
                    require('gitsigns').reset_hunk()
                end,
                desc = 'git [r]eset hunk',
            },
            {
                '<leader>hS',
                function()
                    require('gitsigns').stage_buffer()
                end,
                desc = 'git [S]tage buffer',
            },
            {
                '<leader>hu',
                function()
                    require('gitsigns').stage_hunk()
                end,
                desc = 'git [u]ndo stage hunk',
            },
            {
                '<leader>hR',
                function()
                    require('gitsigns').reset_buffer()
                end,
                desc = 'git [R]eset buffer',
            },
            {
                '<leader>hp',
                function()
                    require('gitsigns').preview_hunk()
                end,
                desc = 'git [p]review hunk',
            },
            {
                '<leader>hb',
                function()
                    require('gitsigns').blame_line()
                end,
                desc = 'git [b]lame line',
            },
            {
                '<leader>hd',
                function()
                    require('gitsigns').diffthis()
                end,
                desc = 'git [d]iff against index',
            },
            {
                '<leader>hD',
                function()
                    require('gitsigns').diffthis() '@'
                end,
                desc = 'git [D]iff against last commit',
            },
            -- Toggles
            {
                '<leader>tb',
                function()
                    require('gitsigns').toggle_current_line_blame()
                end,
                desc = '[T]oggle git show [b]lame line',
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
