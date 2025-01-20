local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]]

logo = string.rep('\n', 8) .. logo .. '\n\n'

return {
    'nvimdev/dashboard-nvim',
    lazy = false,
    keys = {
        { '<leader>od', '<cmd>Dashboard<cr>', desc = '[O]pen [D]ashboard' },
    },
    config = function()
        local status_ok, dashboard = pcall(require, 'dashboard')
        if not status_ok then
            return
        end

        dashboard.setup {
            theme = 'doom',
            hide = {
                statusline = false,
            },
            config = {
                header = vim.split(logo, '\n'),
                center = {
                    { action = 'Telescope find_files hidden=true', desc = ' Find File', icon = ' ', key = 'f' },
                    { action = 'ene | startinsert', desc = ' New File', icon = ' ', key = 'n' },
                    { action = 'Telescope oldfiles', desc = ' Recent Files', icon = ' ', key = 'r' },
                    { action = 'Telescope live_grep', desc = ' Find Text', icon = ' ', key = 'g' },
                    {
                        action = function()
                            local builtin = require 'telescope.builtin'
                            builtin.find_files { cwd = vim.fn.stdpath 'config' }
                        end,
                        desc = ' Config',
                        icon = ' ',
                        key = 'c',
                    },
                    { action = 'Lazy', desc = ' Lazy', icon = '󰒲 ', key = 'l' },
                    {
                        action = function()
                            vim.api.nvim_input '<cmd>qa<cr>'
                        end,
                        desc = ' Quit',
                        icon = ' ',
                        key = 'q',
                    },
                },
                footer = function()
                    local stats = require('lazy').stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
                end,
            },
        }
    end,
}
