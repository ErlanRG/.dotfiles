-- autopairs
-- https://github.com/windwp/nvim-autopairs
return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    dependencies = { 'hrsh7th/nvim-cmp' },
    opts = {
        map_char = {
            all = '(',
            tex = '{',
        },
        enable_check_bracket_line = false,
        check_ts = true,
        ts_config = {
            lua = { 'string', 'source' },
            javascript = { 'string', 'template_string' },
            java = false,
        },
        disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
        enable_moveright = true,
        disable_in_macro = false,
        enable_afterquote = true,
        map_bs = true,
        map_c_w = false,
        disable_in_visualblock = false,
        fast_wrap = {
            map = '<M-e>',
            chars = { '{', '[', '(', '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
            offset = 0, -- Offset from pattern match
            end_key = '$',
            keys = 'qwertyuiopzxcvbnmasdfghjkl',
            check_comma = true,
            highlight = 'Search',
            highlight_grey = 'Comment',
        },
    },
    config = function(_, opts)
        local status_autopairs_ok, autopairs = pcall(require, 'nvim-autopairs')
        if not status_autopairs_ok then
            return
        end

        autopairs.setup(opts)
        -- If you want to automatically add `(` after selecting a function or method
        local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
        local cmp = require 'cmp'
        cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
}
