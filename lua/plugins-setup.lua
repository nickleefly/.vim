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

  "bluz71/vim-nightfly-guicolors", -- preferred colorscheme

  "christoomey/vim-tmux-navigator", -- tmux & split window navigation

  -- essential plugins
  "inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion

  -- commenting with gc
  "numToStr/Comment.nvim",

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
    },
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

  -- managing & installing lsp servers, linters & formatters
  "williamboman/mason.nvim", -- in charge of managing lsp servers, linters & formatters
  "williamboman/mason-lspconfig.nvim", -- bridges gap b/w mason & lspconfig

  -- configuring lsp servers
  "neovim/nvim-lspconfig", -- easily configure language servers
  "hrsh7th/cmp-nvim-lsp", -- for autocompletion
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  }, -- enhanced lsp uis
  "jose-elias-alvarez/typescript.nvim", -- additional functionality for typescript server (e.g. rename file & update imports
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

  -- chatgpt
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    cmd = "ChatGPT",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
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
})
