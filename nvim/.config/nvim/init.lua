-- General
require('default-config')
require('plugins')
require('keymappings')
require('settings')

-- Plugin configurations
require('pl-telescope')
require('pl-treesitter')
require('pl-nvimtree')
require('pl-autopairs')
require('pl-lspinstall')
require('pl-compe')
require('pl-commenter')
require('pl-colorizer')
require('pl-barbar')
require('pl-dashboard')
require('pl-galaxyline')
require('pl-gitsigns')

-- LSP
require('lsp')
require('lsp.python-ls')
require('lsp.lua-ls')
require('lsp.clangd')
require('lsp.js-ts-ls')
require('lsp.html-ls')
