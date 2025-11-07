local M = {}

--- Extract the name of the virtual environment from a given path or name.
-- Example:
--   env_cleanup("/home/user/.virtualenvs/myenv") => "myenv"
--   env_cleanup("myenv") => "myenv"
--- @param venv (string) Virtual environment name or path.
--- @return (string) environment_name
function M.env_cleanup(venv)
    if string.find(venv, '/') then
        local final_venv = venv
        for w in venv:gmatch '([^/]+)' do
            final_venv = w
        end
        venv = final_venv
    end
    return venv
end

---Normalize a given path to make it work on Windows and Linux OS
---@param path string
---@return string
function M.normalize_path(path)
    path = vim.fn.expand(path)
    local is_windows = vim.loop.os_uname().sysname == 'Windows_NT'
    return is_windows and path:gsub('/', '\\') or path
end

return M
