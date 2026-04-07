-- Highlight todo, notes, etc in comments
return {
    -- TODO comments
    {
        'folke/todo-comments.nvim',
        event = { 'BufReadPost', 'BufNewFile' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = true },
    },

    -- Markdown renderer
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = 'markdown',
        opts = {
            completion = { lsp = { enabled = true } },
        },
    },
}
