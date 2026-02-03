local M = {}

M.clangd = {
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
        '--completion-style=detailed',
        '--function-arg-placeholders',
        '--fallback-style=llvm',
        '--offset-encoding=utf-16',
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
}

M.rust_analyzer = {}

return M
