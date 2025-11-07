local M = {}

local icons = require 'rangeler.utils.icons'

local window_width_limit = 80
local branch = '%#SLGitIcon#' .. icons.git.Branch .. '%*' .. '%#SLBranchName#'

local conditions = {
    hide_in_width = function()
        return vim.o.columns > window_width_limit
    end,
}

M.components = {
    mode = {
        function()
            return ' ' .. icons.ui.Vim .. ' '
        end,
        padding = { left = 0, right = 0 },
        color = {},
        cond = nil,
    },
    branch = {
        'b:gitsigns_head',
        icon = branch,
        color = { gui = 'bold' },
    },
    filename = {
        'filename',
        symbols = {
            modified = icons.ui.Circle, -- Text to show when the file is modified.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = '[New]', -- Text to show for newly created file before first write
        },
        padding = { left = 0, right = 0 },
        color = {},
        path = 0,
        cond = nil,
    },
    filetype = {
        'filetype',
        padding = { left = 0, right = 0 },
        icon_only = true,
        cond = nil,
    },
    diff = {
        'diff',
        symbols = {
            added = icons.git.LineAdded .. ' ',
            modified = icons.git.LineModified .. ' ',
            removed = icons.git.LineRemoved .. ' ',
        },
        padding = { left = 2, right = 1 },
        color = { bg = '' },
        cond = nil,
    },
    python_env = {
        function()
            local utils = require 'rangeler.utils.misc'
            if vim.bo.filetype == 'python' then
                local venv = os.getenv 'CONDA_DEFAULT_ENV' or os.getenv 'VIRTUAL_ENV'
                if venv then
                    local web_icdons = require 'nvim-web-devicons'
                    local py_icon, _ = web_icdons.get_icon '.py'
                    return string.format(' ' .. py_icon .. ' (%s)', utils.env_cleanup(venv))
                end
            end
            return ''
        end,
        cond = conditions.hide_in_width,
    },
    diagnostics = {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = {
            error = icons.diagnostics.BoldError .. ' ',
            warn = icons.diagnostics.BoldWarning .. ' ',
            info = icons.diagnostics.BoldInformation .. ' ',
            hint = icons.diagnostics.BoldHint .. ' ',
        },
    },
    treesitter = {
        function()
            return icons.ui.Tree
        end,
        color = function()
	    local colors = require 'catppuccin.palettes.mocha'
            local buf = vim.api.nvim_get_current_buf()
            local ts = vim.treesitter.highlighter.active[buf]
            return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
        end,
        cond = conditions.hide_in_width,
    },
    lsp = {
        function()
            local buf_clients = vim.lsp.get_clients { bufnr = 0 }
            if #buf_clients == 0 then
                return 'LSP Inactive'
            end

            -- local buf_ft = vim.bo.filetype
            local buf_client_names = {}
            local copilot_active = false

            -- add client
            for _, client in pairs(buf_clients) do
                if client.name ~= 'copilot' then
                    table.insert(buf_client_names, client.name)
                end

                if client.name == 'copilot' then
                    copilot_active = true
                end

                -- add formatter
                local formatters = require 'conform.formatters'
                vim.list_extend(buf_client_names, formatters)

                local unique_client_names = table.concat(buf_client_names, ', ')
                local language_servers = string.format(icons.ui.Gear .. ' LSP: %s', unique_client_names)

                if copilot_active then
                    language_servers = language_servers .. '%SLCopilot#' .. ' ' .. icons.kind.Copilot .. '%*'
                end

                return language_servers
            end
        end,
        color = { gui = 'bold' },
        cond = conditions.hide_in_width,
    },
    location = { 'location' },
    progress = {
        'progress',
        fmt = function()
            return '%P/%L'
        end,
        color = {},
    },
    spaces = {
        function()
            local shiftwidth = vim.api.nvim_get_option_value('shiftwidth', { buf = 0 })
            return icons.ui.Tab .. ' ' .. shiftwidth
        end,
        padding = 1,
    },
    scrollbar = {
        function()
            local current_line = vim.fn.line '.'
            local total_lines = vim.fn.line '$'
            local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
            local line_ratio = current_line / total_lines
            local index = math.ceil(line_ratio * #chars)
            return chars[index]
        end,
        padding = { left = 0, right = 0 },
        color = 'SLProgress',
        cond = nil,
    },
}

return M
