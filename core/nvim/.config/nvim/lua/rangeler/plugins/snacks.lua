local snacks_opts = require 'rangeler.plugins.custom.snacks_opts'

-- Collection of various small independent plugins/modules
return {
    {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.ai').setup { n_lines = 500 }
        end,
    },

    -- Snacks
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        keys = {
            -- stylua: ignore start
            { "<leader>/", function() Snacks.picker.buffers() end, desc = "[F]ind [B]uffers" },
            { '<leader>bd', function() Snacks.bufdelete() end, desc = '[B]uffer [D]elete' },
            { '<leader>od', function() Snacks.dashboard() end, desc = '[O]pen [D]ashboard' },
            { '<leader>og', function() Snacks.lazygit() end, desc = '[O]pen Lazy[G]it' },
            { '<leader>on', function() Snacks.notifier.show_history() end, desc = '[O]pen [N]otifications' },
            { '<leader>os', function() Snacks.scratch() end, desc = '[O]pen [S]cratch' },
            { '<leader>oss', function() Snacks.scratch.select() end, desc = '[O]pen [S]elect [S]cratch' },

            -- Picker
            { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },

            -- Find
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "[F]ind [B]uffers" },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[F]ind [C]onfig Files" },
            { "<leader>ff", function() Snacks.picker.files({ hidden = true }) end, desc = "[F]ind [F]iles" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "[F]ind [G]it Files" },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "[F]ind [P]rojects" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "[F]ind [R]ecent" },

            -- Search (grep)
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "[S]earch Grep Open [B]uffers" },
            { "<leader>sC", function() Snacks.picker.commands() end, desc = "[S]earch [C]ommands" },
            { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "[S]earch Buffer [D]iagnostics" },
            { "<leader>sG", function() Snacks.picker.git_grep() end, desc = "[S]earch [G]it Grep" },
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "[S]earch Buffer [L]ines" },
            { "<leader>sc", function() Snacks.picker.command_history() end, desc = "[S]earch [C]ommand History" },
            { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[S]earch [D]iagnostics" },
            { "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch [G]rep" },
            { "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp Pages" },
            { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
            { "<leader>sq", function() Snacks.picker.qflist() end, desc = "[S]earch [Q]uickfix List" },
            { "<leader>su", function() Snacks.picker.undo() end, desc = "[S]earch [U]ndo History" },
            { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch Visual selection or [w]ord", mode = { "n", "x" }},
            { '<leader>st', function() Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME', 'NOTE' } } end, desc = '[S]earch Visual selection or [w]ord', mode = { 'n', 'x' }, },
            -- stylua: ignore end
        },
        opts = {
            -- Built-in
            bigfile = { enabled = true },
            dim = { enabled = true },
            image = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            statuscolumn = { enabled = true },

            -- Custom
            dashboard = snacks_opts.dashboard,
            indent = snacks_opts.indent,
            picker = snacks_opts.picker,
        },
        init = function()
            vim.api.nvim_create_autocmd('User', {
                pattern = 'VeryLazy',
                callback = function()
                    Snacks.toggle.dim():map '<leader>td'
                end,
            })
        end,
    },
}
