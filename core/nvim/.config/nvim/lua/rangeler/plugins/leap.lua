return {
    'ggandor/leap.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local status_ok, leap = pcall(require, 'leap')
        if not status_ok then
            return
        end

        local map = vim.keymap.set

        leap.create_default_mappings()
        leap.opts.case_sensitive = false

        -- Remap required to avoid issues with other similar mappings.
        map({ 'n', 'x', 'o' }, 'sg', '<Plug>(leap-from-window)')
    end,
}
