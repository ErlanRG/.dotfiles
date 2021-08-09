CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

O = {
    auto_close_tree = 0,
    auto_complete = true,
    hidden_files = true,
    wrap_lines = false,
    number = true,
    relative_number = true,
    cursorline = true,
    shell = 'bash',
    timeoutlen = 100,
    nvim_tree_disable_netrw = 0,
    extras = false,
    ignore_case = true,
    smart_case = true,

    -- @usage pass a table with your desired languages
    treesitter = {
        ensure_installed = "all",
        ignore_install = {"haskell"},
        highlight = {enabled = true},
        rainbow = {enabled = false}
    },

    database = {save_location = '~/.config/nvcode_db', auto_execute = 1},
}

