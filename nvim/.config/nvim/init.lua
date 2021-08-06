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
require('pl-zenmode')
require('pl-gitsigns')

-- LSP  
require('lsp')
-- if O.lang.python.active then require('lsp.python-ls') end
