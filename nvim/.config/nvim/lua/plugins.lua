return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = true,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  { "navarasu/onedark.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "nvim-lua/popup.nvim" }, -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used ny lots of plugins

  -- Autopairs
  { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter

  -- Barbar
  { "romgrk/barbar.nvim", commit = "875ae20301cf13b8410f75d62857f87e2c53a58b" },

  -- Cmp
  { "L3MON4D3/LuaSnip" }, --snippet engine
  { "hrsh7th/cmp-buffer" }, -- buffer completions
  { "hrsh7th/cmp-cmdline" }, -- cmdline completions
  { "hrsh7th/cmp-nvim-lsp" }, -- lsp based completions
  { "hrsh7th/cmp-nvim-lua" }, -- lua completions
  { "hrsh7th/cmp-path" }, -- path completions
  { "hrsh7th/nvim-cmp" }, -- The completion plugin
  { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
  { "saadparwaiz1/cmp_luasnip" }, -- snippet completions

  -- Colorizer
  { "norcalli/nvim-colorizer.lua" },

  -- Comments
  { "numToStr/Comment.nvim" }, -- Easily comment stuff

  -- Copilot
  { "zbirenbaum/copilot.lua" },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  -- Fugitive
  { "tpope/vim-fugitive" },

  -- Gitsigns
  { "lewis6991/gitsigns.nvim" },

  -- Harpoon
  { "ThePrimeagen/harpoon" },

  -- Illuminate
  { "RRethy/vim-illuminate" },

  -- Impatient
  { "lewis6991/impatient.nvim" },

  -- Indent lines
  { "lukas-reineke/indent-blankline.nvim" },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason-lspconfig.nvim" },
  { "williamboman/mason.nvim" },

  -- Lualine
  { "nvim-lualine/lualine.nvim" },

  -- Null-ls
  { "jose-elias-alvarez/null-ls.nvim" },

  -- Nvim leap
  { "ggandor/leap.nvim" },

  -- Nvim tree
  { "kyazdani42/nvim-tree.lua" },
  { "kyazdani42/nvim-web-devicons" },

  -- Nvim-navic
  { "SmiteshP/nvim-navic" },

  -- Project
  { "ahmedkhalf/project.nvim" },

  -- Rust
  { "simrat39/rust-tools.nvim" },

  -- Telescope
  { "nvim-telescope/telescope-media-files.nvim" },
  { "nvim-telescope/telescope.nvim" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  -- { "HiPhish/nvim-ts-rainbow2" },
}
