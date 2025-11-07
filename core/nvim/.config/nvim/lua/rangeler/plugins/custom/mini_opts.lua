local M = {}

M.mini_files_opts = {
    mappings = {
        -- Close explorer after opening file with 'l'
        go_in = 'L',
        go_in_plus = 'l',
        synchronize = '<CR>',
    },
    windows = {
        preview = true,
    },
}

M.ai_opts = {
    n_lines = 500,
}

return M
