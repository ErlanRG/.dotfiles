return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    commit = "2e3e5ebcdc24ef0d5b14a0a999dbbe7936512c46",
  },
  { "navarasu/onedark.nvim" },
  {
    "rose-pine/neovim",
    name = "rose-pine",
  },
  { "nvim-lua/popup.nvim" },   -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used ny lots of plugins

  -- Autopairs
  { "windwp/nvim-autopairs" }, -- Autopairs, integrates with both cmp and treesitter

  -- Barbar
  { "romgrk/barbar.nvim" },

  -- Cmp
  { "L3MON4D3/LuaSnip" },             --snippet engine
  { "hrsh7th/cmp-buffer" },           -- buffer completions
  { "hrsh7th/cmp-cmdline" },          -- cmdline completions
  { "hrsh7th/cmp-nvim-lsp" },         -- lsp based completions
  { "hrsh7th/cmp-nvim-lua" },         -- lua completions
  { "hrsh7th/cmp-path" },             -- path completions
  { "hrsh7th/nvim-cmp" },             -- The completion plugin
  { "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use
  { "saadparwaiz1/cmp_luasnip" },     -- snippet completions

  -- Colorizer
  { "norcalli/nvim-colorizer.lua" },

  -- Comments
  { "numToStr/Comment.nvim" }, -- Easily comment stuff

  -- Copilot
  { "zbirenbaum/copilot.lua" },
  { "zbirenbaum/copilot-cmp" },

  -- Dashboard
  { "goolord/alpha-nvim" },

  -- Fidget
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
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

  -- Nvim-navic
  { "SmiteshP/nvim-navic" },
  -- Neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },

  -- Rust
  { "simrat39/rust-tools.nvim" },

  -- Telescope
  { "nvim-telescope/telescope-media-files.nvim" },
  { "nvim-telescope/telescope.nvim" },

  -- Trouble
  { "folke/trouble.nvim" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  { "HiPhish/nvim-ts-rainbow2" },
}
