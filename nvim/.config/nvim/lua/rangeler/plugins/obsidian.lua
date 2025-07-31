return {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    lazy = true,
    event = {
        -- stylua: ignore
        'BufReadPre ' .. vim.fn.expand '~' .. '/Documents/Notes/*.md',
        'BufNewFile ' .. vim.fn.expand '~' .. '/Documents/Notes/*.md',
    },
    keys = {
        { '<leader>Ob', '<cmd>Obsidian backlinks<cr>', desc = '[B]acklink references' },
        { '<leader>Oe', '<cmd>Obsidian extract_note<cr>', desc = '[E]xtract note' },
        { '<leader>Of', '<cmd>Obsidian follow_link<cr>', desc = '[F]ollow link' },
        { '<leader>On', '<cmd>Obsidian new<cr>', desc = '[N]ew note' },
        { '<leader>Op', '<cmd>Obsidian paste_img<cr>', desc = '[P]aste image' },
        { '<leader>Or', '<cmd>Obsidian rename<cr>', desc = '[R]ename current note' },
        { '<leader>Ot', '<cmd>Obsidian tags<cr>', desc = '[T]ags' },
    },
    opts = {
        attachments = {
            img_folder = 'Assets/Images',
            img_name_func = function()
                return string.format('Pasted image %s', os.date '%Y%m%d%H%M%S')
            end,
            confirm_img_paste = false,
        },
        completion = {
            blink = true,
        },
        legacy_commands = false,
        note_id_func = function(title)
            local suffix = ''
            if title ~= nil then
                suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
            else
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.time()) .. '-' .. suffix
        end,
        workspaces = {
            {
                name = 'notes',
                path = '~/Documents/Notes',
            },
        },
    },
}
