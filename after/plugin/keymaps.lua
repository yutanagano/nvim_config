local builtin = require('telescope.builtin')

-- navigation
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.git_files, {})
vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})

-- language and refactoring
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {})

-- yanking and pasting
vim.keymap.set('', '<leader>y', '"+y', {})
vim.keymap.set('n', '<leader>p', '"+p', {})

-- spelling
vim.keymap.set('n', '<leader>s', ':setlocal spell!<CR>', {})
