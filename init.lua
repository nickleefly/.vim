-- Suppress deprecation warnings from null-ls plugin
vim.deprecate = function() end

require("plugins-setup")
require("core.options")
require("core.keymaps")
require("core.colorscheme")
