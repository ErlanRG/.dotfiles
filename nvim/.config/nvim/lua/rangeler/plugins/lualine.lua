local icons = require 'rangeler.utils.icons'
-- Just give me the logo
local function vim_mode_logo()
    return icons.ui.Vim
end

local conditions = {
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
}

local function lsp_server_name()
    local msg = 'No Active LSP'
    local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
        return msg
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= 1 then
            return client.name
        end
    end
    return msg
end

return {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
        options = {
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = { { vim_mode_logo } },
            lualine_b = {
                { 'branch' },
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    symbols = {
                        error = icons.diagnostics.BoldError .. ' ',
                        warn = icons.diagnostics.BoldWarning .. ' ',
                        info = icons.diagnostics.BoldInformation .. ' ',
                        hint = icons.diagnostics.BoldHint .. ' ',
                    },
                },
            },
            lualine_c = {
                {
                    'filename',
                    cond = conditions.hide_in_width,
                    color = { gui = 'bold' },
                },
            },
            lualine_x = {
                {
                    'diff',
                    symbols = {
                        added = icons.git.BoldLineAdded .. ' ',
                        modified = icons.git.BoldLineModified .. ' ',
                        removed = icons.git.BoldLineRemoved .. ' ',
                    },
                },
                {
                    'filetype',
                    cond = conditions.hide_in_width,
                },
                {
                    lsp_server_name,
                    icon = icons.ui.Gear .. ' LSP:',
                },
            },
        },
    },
}
