return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    config = function()
        ---@see https://github.com/mbwilding/nvim/blob/main/lua/plugins/treesitter.lua
        -- Treesitter directory
        local treesitter_dir = vim.fn.stdpath 'data' .. '/lazy/nvim-treesitter/'

        -- Collect all available parsers
        -- TODO: I don't really need all of the available parsers. Fix this to
        -- use necessary only.
        local parsers = {}
        for name, type in vim.fs.dir(treesitter_dir .. 'runtime/queries') do
            if type == 'directory' then
                table.insert(parsers, name)
            end
        end

        -- Install file type parsers
        local ok, ts = pcall(require, 'nvim-treesitter')
        if not ok then
            return
        end
        ts.install(parsers)

        -- Register known file types
        dofile(treesitter_dir .. 'plugin/filetypes.lua')

        -- Get file types
        local file_types = vim.iter(parsers)
            :map(function(parser)
                return vim.treesitter.language.get_filetypes(parser)
            end)
            :flatten()
            :totable()

        -- Auto-run
        vim.api.nvim_create_autocmd('FileType', {
            pattern = file_types,
            callback = function(args)
                -- Highlights
                vim.treesitter.start()

                -- Folds
                -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                -- vim.wo[0][0].foldmethod = 'expr'

                -- Indentation
                vim.bo[args.buf].indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
            end,
        })
    end,
}
