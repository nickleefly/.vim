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
  {
    "numToStr/Comment.nvim",
    config = function()
      require("plugins.comment")
    end,
  },

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- buffer
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("plugins.bufferline")
    end,
  },

  -- vs-code like icons
  "nvim-tree/nvim-web-devicons",

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("plugins.lualine")
    end,
  },

  -- fuzzy finding w/ telescope
  -- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      require("plugins.telescope")
    end,
  },

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
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      require("plugins.nvim-cmp")
    end,
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
    config = function()
      require("plugins.lsp.lspconfig")
    end,
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
    config = function()
      require("ibl").setup({})
    end,
    opts = {
      char = "┊",
      show_trailing_blankline_indent = false,
    },
  },

  -- enhanced lsp uis formatting & linting
  {
    "nvimtools/none-ls.nvim",
    config = function()
      require("plugins.lsp.null-ls")
    end,
  },
  {
    "jayp0521/mason-null-ls.nvim",
    config = function()
      require("plugins.lsp.mason")
    end,
  },

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
    config = function()
      require("plugins.treesitter")
    end,
  },

  -- auto closing
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs")
    end,
  },

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
  {
    "ggandor/leap.nvim",
    config = function()
      require("plugins.leap")
    end,
  },

  -- whichkey
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- trouble
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("plugins.gitsigns")
    end,
  },
  "airblade/vim-gitgutter",
  "f-person/git-blame.nvim",
})
