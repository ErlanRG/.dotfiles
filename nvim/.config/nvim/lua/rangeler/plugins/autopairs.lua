-- autopairs
-- https://github.com/windwp/nvim-autopairs
return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
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
        disable_in_macro = false,
        disable_in_visualblock = false,
        disable_in_replace_mode = true,
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
        enable_moveright = true,
        enable_afterquote = true,
        enable_abbr = false,
        break_undo = true,
        map_cr = true,
        map_bs = true,
        map_c_w = false,
        map_c_h = false,
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
    end,
}
