local opts = { noremap = true, silent = true }

local nvim_set_keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
nvim_set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation
nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)

-- Launch netrw directory explorer with shortcut
vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, opts)

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fr', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
