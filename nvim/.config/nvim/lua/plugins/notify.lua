local M = {
  "rcarriga/nvim-notify",
}

function M.config()
  local ok, notify = pcall(require, "notify")
  if not ok then
    return
  end

  local config = {
    fps = 60,
    stages = "slide",
    timeout = 2000,
  }

  notify.setup(config)

  vim.notify = notify
end

return M
