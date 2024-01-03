local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
}

function M.config()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"

  dashboard.section.header.val = {
    [[                                                                                ]],
    [[                           ((##                   ((%                           ]],
    [[                         ((((####                 (((((                         ]],
    [[                      (((((((#####                (((((((%                      ]],
    [[                    //(((((((#######              ((((((((((                    ]],
    [[                  //////(((((########%            (((((((((((                   ]],
    [[                  ///////((((##########           (((((((((((                   ]],
    [[                  /////////((############         (((((((((((                   ]],
    [[                  ///////////#############        (((((((((((                   ]],
    [[                  ////////////&#############      (((((((((((                   ]],
    [[                  ////////////  ##############    (((((((((((                   ]],
    [[                  ////////////    #############   (((((((((((                   ]],
    [[                  ////////////     &############# (((((((((((                   ]],
    [[                  ////////////       ##############((((((((((                   ]],
    [[                  ////////////         ############((((((((((                   ]],
    [[                  ////////////          &##########((((((((((                   ]],
    [[                  ////////////            #########((((#(((((                   ]],
    [[                   ///////////              #######((((((((((                   ]],
    [[                     (////////               &#####(((((((                      ]],
    [[                        //////                 ####(((((                        ]],
    [[                          (///                   ##((                           ]],
    [[                             /                    &                             ]],
    [[                                                                                ]],
    [[                                                                                ]],
    [[                                     N E O V I M                                ]],
    [[                                                                                ]],
  }

  dashboard.section.buttons.val = {
    dashboard.button("f", "󰈞  Find file", ":Telescope find_files <CR>"),
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
    dashboard.button("u", "  Update packages", ":Lazy sync<CR>"),
    dashboard.button("c", "  Configuration", ":Telescope find_files cwd=~/.config/nvim/ <CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    local user = vim.fn.expand "$USER"
    return " " .. user .. "  "
  end

  dashboard.section.footer.val = footer()

  dashboard.section.header.opts.hl = "Include"
  dashboard.section.footer.opts.hl = "Type"
  dashboard.section.buttons.opts.hl = "Keyword"

  dashboard.opts.opts.noautocmd = true

  -- Disable tabline in Alpha buffer
  vim.cmd [[ autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2 ]]

  alpha.setup(dashboard.opts)
end

return M
