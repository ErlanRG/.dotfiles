-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true -- Set to true if you have a Nerd Font installed and selected in the terminal

-- [[ Setting options ]]
-- See `:help vim.opt`
local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.breakindent = true -- Enable break indent
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Show which line your cursor is on
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.ignorecase = true -- Case-insensitive searching
opt.inccommand = 'split' -- Preview substitutions live, as you type!
opt.iskeyword:append '-'
opt.jumpoptions = 'view'
opt.laststatus = 3 -- Same statusline for all windows
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Make line numbers default
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative numbers
opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.showmode = false -- Don't show the mode, since it's already in the status line
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes' -- Keep signcolumn on by default
opt.smartcase = true
opt.smartindent = true -- Insert indents automatically
opt.splitbelow = true
opt.splitkeep = 'screen'
opt.splitright = true
opt.tabstop = 4 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300 -- Decrease mapped sequence wait time
opt.undofile = true -- Save undo history
opt.updatetime = 250 -- Decrease update time
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
    opt.clipboard = 'unnamedplus'
end)
