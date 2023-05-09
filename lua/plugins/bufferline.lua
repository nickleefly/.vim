vim.opt.termguicolors = true
require("bufferline").setup({})

vim.keymap.set("n", "gb", "<CMD>BufferLinePick<CR>")
vim.keymap.set("n", "<leader>ts", "<CMD>BufferLinePickClose<CR>")
vim.keymap.set("n", "]b", "<CMD>BufferLineCycleNext<CR>")
vim.keymap.set("n", "[b", "<CMD>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "gs", "<CMD>BufferLineSortByDirectory<CR>")
