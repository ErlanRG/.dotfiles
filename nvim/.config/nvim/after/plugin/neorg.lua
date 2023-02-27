local ok, neorg = pcall(require, "neorg")
if not ok then
  return
end

local opts = {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          notes = "~/notes",
        },
      },
    },
  },
}

neorg.setup(opts)
