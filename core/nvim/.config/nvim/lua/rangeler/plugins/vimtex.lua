local cwd = vim.fn.expand '%:p:h' -- cwd of current buffer

return {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    keys = {
        { '<leader>lc', '<cmd>VimtexCompile<cr>', desc = 'Toggle [C]ompiler' },
    },
    init = function()
        -- VimTeX configuration goes here, e.g.
        vim.g.vimtex_compiler_method = 'latexmk'
        vim.g.vimtex_compiler_latexmk = {
            aux_dir = cwd .. '/aux',
            out_dir = cwd .. '/out',
        }
        vim.g.vimtex_view_method = 'zathura'
    end,
}
