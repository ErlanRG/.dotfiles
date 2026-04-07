return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    dependencies = {
        { 'romus204/tree-sitter-manager.nvim', opts = {} },
    },
    event = { 'BufReadPost', 'BufNewFile' },
    lazy = false,
    config = function()
        -- ensure basic parser are installed
        local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
        local ok, ts = pcall(require, 'nvim-treesitter')
        if not ok then
            return
        end
        ts.install(parsers)

        ---@param buf integer
        ---@param language string
        local function treesitter_try_attach(buf, language)
            -- check if parser exists and load it
            if not vim.treesitter.language.add(language) then
                return
            end
            -- enables syntax highlighting and other treesitter features
            vim.treesitter.start(buf, language)

            -- enables treesitter based indentation
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        local available_parsers = ts.get_available()
        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args)
                local buf, filetype = args.buf, args.match

                local language = vim.treesitter.language.get_lang(filetype)
                if not language then
                    return
                end

                local installed_parsers = ts.get_installed 'parsers'

                if vim.tbl_contains(installed_parsers, language) then
                    -- enable the parser if it is installed
                    treesitter_try_attach(buf, language)
                elseif vim.tbl_contains(available_parsers, language) then
                    -- if a parser is available in `nvim-treesitter` auto install it, and enable it after the installation is done
                    ts.install(language):await(function()
                        treesitter_try_attach(buf, language)
                    end)
                else
                    -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
                    treesitter_try_attach(buf, language)
                end
            end,
        })
    end,
}
