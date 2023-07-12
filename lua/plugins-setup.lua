-- auto install lazy if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- import packer safely
local status, lazy = pcall(require, "lazy")
if not status then
  return
end

-- add list of plugins to install
return lazy.setup({
  {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },

  "nvim-lua/plenary.nvim", -- lua functions that many plugins use

  "EdenEast/nightfox.nvim",

  "christoomey/vim-tmux-navigator", -- tmux & split window navigation

  -- essential plugins
  "inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion

  -- commenting with gc
  "numToStr/Comment.nvim",

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- buffer
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

  -- vs-code like icons
  "nvim-tree/nvim-web-devicons",

  -- statusline
  "nvim-lualine/lualine.nvim",

  -- fuzzy finding w/ telescope
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- dependency for better sorting performance
  { "nvim-telescope/telescope.nvim", branch = "0.1.x" }, -- fuzzy finder

  "junegunn/fzf",
  "junegunn/fzf.vim",
  { "ibhagwan/fzf-lua", dependencies = "nvim-tree/nvim-web-devicons" },

  -- autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
  },

  {
    -- configuring lsp servers
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      -- in charge of managing lsp servers, linters & formatters
      "williamboman/mason.nvim",
      -- managing & installing lsp servers, linters & formatters
      "williamboman/mason-lspconfig.nvim",
      -- for autocompletion
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  {
    "glepnir/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = "┊",
      show_trailing_blankline_indent = false,
    },
  },

  -- enhanced lsp uis
  "L3MON4D3/LuaSnip", -- snippet engine
  "saadparwaiz1/cmp_luasnip", -- for autocompletion
  "onsails/lspkind.nvim", -- vs-code like icons for autocompletion

  -- formatting & linting
  "jose-elias-alvarez/null-ls.nvim", -- configure formatters & linters
  "jayp0521/mason-null-ls.nvim", -- bridges gap b/w mason & null-ls

  -- treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
  },

  -- auto closing
  "windwp/nvim-autopairs", -- autoclose parens, brackets, quotes, etc...

  -- selection
  "mg979/vim-visual-multi",
  "gcmt/wildfire.vim",

  -- neoformat
  "sbdchd/neoformat",

  -- tpope Repeat
  "tpope/vim-repeat",
  "tpope/vim-surround", -- add, delete, change surroundings (it's awesome
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",

  -- leap motion
  "ggandor/leap.nvim",

  -- whichkey
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },

  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/notes",
            },
          },
        },
      },
    },
    dependencies = { { "nvim-lua/plenary.nvim" } },
  },

  -- -- latex markdown
  -- "lervag/vimtex",
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- trouble
  -- {
  --   "folke/trouble.nvim",
  --   dependencies = "nvim-tree/nvim-web-devicons",
  --   config = function()
  --     require("trouble").setup({
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     })
  --   end,
  -- },

  -- git integration
  "lewis6991/gitsigns.nvim", -- show line modifications on left hand side
  "airblade/vim-gitgutter",
  "f-person/git-blame.nvim",
})
