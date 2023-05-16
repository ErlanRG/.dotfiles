return {
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = "module",
      },
      prefix = "self",
    },
    cargo = {
      buildScripts = {
        enable = true,
      },
    },
    procMacro = {
      enable = true,
    },
  },
}
