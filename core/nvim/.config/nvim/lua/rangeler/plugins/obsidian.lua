local utils = require 'rangeler.utils.misc'

local vaults = {
    notes = {
        name = 'notes',
        path = '~/Documents/Notes',
    },
}

-- Normalize all paths from vaults
for _, vault in pairs(vaults) do
    vault.normalized_path = utils.normalize_path(vault.path)
end

return {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    lazy = true,
    event = function() -- Triggers the events for all the vaults in the list.
        local events = {}
        for _, vault in pairs(vaults) do
            local path = vault.normalized_path
            table.insert(events, 'BufReadPre ' .. path .. '/*.md')
            table.insert(events, 'BufNewFile ' .. path .. '/*.md')
        end
        return events
    end,
    keys = {
        { '<leader>Ob', '<cmd>Obsidian backlinks<cr>', desc = '[B]acklink references' },
        { '<leader>Oe', '<cmd>Obsidian extract_note<cr>', desc = '[E]xtract note' },
        { '<leader>Of', '<cmd>Obsidian follow_link<cr>', desc = '[F]ollow link' },
        { '<leader>On', '<cmd>Obsidian new<cr>', desc = '[N]ew note' },
        { '<leader>Oo', '<cmd>Obsidian open<cr>', desc = '[O]pen Obsidian' },
        { '<leader>Op', '<cmd>Obsidian paste_img<cr>', desc = '[P]aste image' },
        { '<leader>Or', '<cmd>Obsidian rename<cr>', desc = '[R]ename current note' },
        { '<leader>Ot', '<cmd>Obsidian tags<cr>', desc = '[T]ags' },
    },
    config = function()
        local ok, obsidian = pcall(require, 'obsidian')
        if not ok then
            return
        end

        obsidian.setup {
            attachments = {
                folder = 'Attachments',
                img_name_func = function()
                    return string.format('Pasted image %s', os.date '%Y%m%d%H%M%S')
                end,
                confirm_img_paste = false,
            },
            legacy_commands = false,
            note_id_func = require('obsidian.builtin').title_id,
            workspaces = vim.tbl_values(vaults),
            checkbox = {
                enabled = true,
                create_new = true,
                order = { ' ', '~', '!', '>', 'x' },
            },
            ui = {
                enable = true,
                ignore_conceal_warn = false,
                update_debounce = 200,
                max_file_length = 5000,
                bullets = { char = '•', hl_group = 'ObsidianBullet' },
                external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
                reference_text = { hl_group = 'ObsidianRefText' },
                highlight_text = { hl_group = 'ObsidianHighlightText' },
                tags = { hl_group = 'ObsidianTag' },
                block_ids = { hl_group = 'ObsidianBlockID' },
                follow_url_func = function(url)
                    local browser = os.getenv 'BROWSER'
                    vim.ui.open(url, { cmd = { browser } })
                end,
            },
        }
    end,
}
