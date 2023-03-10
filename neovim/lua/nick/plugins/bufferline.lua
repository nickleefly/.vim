vim.opt.termguicolors = true
require("bufferline").setup({})

vim.keymap.set("n", "gb", "<CMD>BufferLinePick<CR>")
vim.keymap.set("n", "<leader>ts", "<CMD>BufferLinePickClose<CR>")
vim.keymap.set("n", "<S-l>", "<CMD>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "]b", "<CMD>BufferLineMoveNext<CR>")
vim.keymap.set("n", "[b", "<CMD>BufferLineMovePrev<CR>")
vim.keymap.set("n", "gs", "<CMD>BufferLineSortByDirectory<CR>")
