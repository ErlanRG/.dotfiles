local M = {}
local icons = require 'rangeler.utils.icons'

-- Dashboard
M.dashboard = {
    sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        {
            pane = 2,
            icon = icons.git.GitLogo,
            desc = 'Browse Repo',
            padding = 1,
            key = 'b',
            action = function()
                Snacks.gitbrowse()
            end,
        },
        { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
        { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
        {
            pane = 2,
            icon = icons.git.Branch,
            title = 'Git Status',
            section = 'terminal',
            enabled = function()
                return Snacks.git.get_root() ~= nil
            end,
            cmd = 'git --no-pager diff --stat -B -M -C',
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
        },
        { section = 'startup', pane = 2 },
    },
}

-- Indent
-- NOTE: workaround to change the indent line color.
vim.api.nvim_set_hl(0, 'SnacksIndentScope', { fg = '#eff1f5' })
M.indent = {
    priority = 1,
    char = icons.ui.LineLeft,
    scope = {
        hl = 'SnacksIndentScope',
    },
    chunk = {
        hl = 'SnacksIndentScope',
    },
    animate = {
        enabled = false,
    },
}

-- Pickers opts
M.picker = {
    buffers = {
        win = {
            list = { keys = { ['dd'] = 'bufdelete' } },
        },
    },
    sources = {
        explorer = { hidden = true },
    },
}

return M
