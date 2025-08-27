local snacks_opts = require 'rangeler.plugins.custom.snacks_opts'
local mini_opts = require 'rangeler.plugins.custom.mini_opts'

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
            require('mini.ai').setup(mini_opts.ai_opts)
            require('mini.files').setup(mini_opts.mini_files_opts)
        end,
        keys = {
            -- stylua: ignore start
            { '<leader>oe', function() MiniFiles.open() end, desc = '[O]pen [E]xplorer' },
            -- stylua: ignore end
        },
    },

    -- Snacks
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        keys = {
            -- stylua: ignore start
            { '<leader>;', function() Snacks.dashboard() end, desc = 'Dashboard' },
            { "<leader>/", function() Snacks.picker.buffers() end, desc = "[F]ind [B]uffers" },
            { '<leader>bd', function() Snacks.bufdelete() end, desc = '[B]uffer [D]elete' },
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
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "[S]earch Buffer [L]ines" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "[S]earch Grep Open [B]uffers" },
            { "<leader>sc", function() Snacks.picker.command_history() end, desc = "[S]earch [C]ommand History" },
            { "<leader>sC", function() Snacks.picker.commands() end, desc = "[S]earch [C]ommands" },
            { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "[S]earch [D]iagnostics" },
            { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "[S]earch Buffer [D]iagnostics" },
            { "<leader>sg", function() Snacks.picker.grep() end, desc = "[S]earch [G]rep" },
            { "<leader>sG", function() Snacks.picker.git_grep() end, desc = "[S]earch [G]it Grep" },
            { "<leader>sh", function() Snacks.picker.help() end, desc = "[S]earch [H]elp Pages" },
            { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "[S]earch [K]eymaps" },
            { "<leader>sq", function() Snacks.picker.qflist() end, desc = "[S]earch [Q]uickfix List" },
            { "<leader>su", function() Snacks.picker.undo() end, desc = "[S]earch [U]ndo History" },
            { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "[S]earch Visual selection or [w]ord", mode = { "n", "x" }},
            -- stylua: ignore end
        },
        opts = {
            -- Built-in
            -- explorer = { enabled = true },
            bigfile = { enabled = true },
            dim = { enabled = true },
            input = { enabled = true },
            image = { enabled = true },
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
