local icons = require 'rangeler.utils.icons'

-- NOTE: workaround to change the indent line color.
vim.api.nvim_set_hl(0, 'SnacksIndentScope', { fg = '#eff1f5' })

return {
    priority = 1,
    char = icons.ui.LineLeft,
    scope = {
        hl = 'SnacksIndentScope',
    },
    chunk = {
        hl = 'SnacksIndentScope',
    },
}
