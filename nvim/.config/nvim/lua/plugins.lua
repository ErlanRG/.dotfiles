-- Install packer.nvim automatically
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- Telescope
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- Devicons
    use 'kyazdani42/nvim-web-devicons'

    --Nvim tree
    use 'kyazdani42/nvim-tree.lua'

    -- Autopairs
    use 'windwp/nvim-autopairs'

    -- Nvim compe
    use 'hrsh7th/nvim-compe'

    -- LSP Install
    use 'neovim/nvim-lspconfig'
    use 'kabouzeid/nvim-lspinstall'
    use 'glepnir/lspsaga.nvim'

    -- Commenter
    use 'terrortylor/nvim-comment'

    -- Colorizer
    use 'norcalli/nvim-colorizer.lua'

    -- Barbar
    use {
        "romgrk/barbar.nvim",
        config = function()
            vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', {noremap = true, silent = true})
            vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', {noremap = true, silent = true})
            vim.api.nvim_set_keymap('n', '<S-x>', ':BufferClose<CR>', {noremap = true, silent = true})
        end,
        event = "BufRead"
    }

    -- Dashboard
    use 'glepnir/dashboard-nvim'

    -- Galaxyline
    use 'glepnir/galaxyline.nvim'

    -- Git signs
    use 'lewis6991/gitsigns.nvim'


    -- Colorthemes
    use 'joshdick/onedark.vim'


end)
