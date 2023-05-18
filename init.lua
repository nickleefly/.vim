require("plugins-setup")

require("core.options")
require("core.keymaps")
require("core.colorscheme")

-- Load each plugin from lua/plugins
local plugins = {
  "comment",
  "nvim-tree",
  "lualine",
  "telescope",
  "nvim-cmp",
  "lsp.mason",
  "lsp.lspsaga",
  "lsp.lspconfig",
  "lsp.null-ls",
  "autopairs",
  "treesitter",
  "gitsigns",
  "bufferline",
  "web-devicons",
  "leap",
  "autorun",
  -- "vimtex",
}

local errors = {}
local error_plugins = {}

for _, plugin in pairs(plugins) do
  local ok, err_msg = pcall(require, "plugins." .. plugin)
  if not ok then
    table.insert(errors, err_msg)
    table.insert(error_plugins, plugin)
  end
end

for i, err_msg in pairs(errors) do
  vim.notify(err_msg, vim.log.levels.ERROR, {
    title = "Error loading : " .. error_plugins[i],
  })
end
