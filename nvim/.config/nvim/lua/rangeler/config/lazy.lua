-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
    return
end

lazy.setup {
    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/rangeler/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    { import = 'rangeler.plugins' },
}
-- vim: ts=2 sts=2 sw=2 et
