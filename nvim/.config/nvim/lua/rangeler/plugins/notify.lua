return {
    'rcarriga/nvim-notify',
    event = 'VimEnter',
    opts = {
        fps = 60,
        stages = 'slide',
        timeout = 2000,
    },
    config = function(_, opts)
        local ok, notify = pcall(require, 'notify')
        if not ok then
            return
        end

        notify.setup(opts)

        vim.notify = notify
    end,
}
