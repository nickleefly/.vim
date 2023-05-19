local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------

-- nvim-tree
keymap.set("n", "<leader>-", "<cmd>NvimTreeResize -5<cr>", { desc = "Decrease window width" })
keymap.set("n", "<leader>=", "<cmd>NvimTreeResize +5<cr>", { desc = "Increase window width" })

-- telescope
keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<cr>", { desc = "[S]earch [B]uffer" }) -- list open buffers in current neovim instance

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- fast saving
keymap.set("n", "w!!", "<cmd>w !sudo tee > /dev/null %")
keymap.set("n", "<leader>w", "<cmd>w!<cr>")
keymap.set("n", "<leader>q", "<cmd>q!<cr>")
keymap.set("n", "<leader>s", "<cmd>wq!<cr>")

keymap.set("n", "<leader>zf", "<cmd>lua require('fzf-lua').files()<CR>")
keymap.set("n", "<leader>zb", "<cmd>lua require('fzf-lua').buffers()<CR>")
keymap.set("n", "<leader>zl", "<cmd>lua require('fzf-lua').lines()<CR>")
keymap.set("n", "<leader>za", ":Ag<CR>")
keymap.set("n", "<leader>zr", ":Rg<CR>")
