local builtin = require('telescope.builtin')

-- navigation
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.git_files, {})
vim.keymap.set('n', '<leader>/', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gl', ':bnext<CR>', {})
vim.keymap.set('n', 'gh', ':bprev<CR>', {})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    vim.keymap.set('n', 'gl', ':bnext<CR>', { buffer = true })
    vim.keymap.set('n', 'gh', ':bprev<CR>', { buffer = true })
  end,
})

-- language and refactoring
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {})

-- yanking and pasting
vim.keymap.set('', '<leader>y', '"+y', {})
vim.keymap.set('n', '<leader>p', '"+p', {})

-- spelling
vim.keymap.set('n', '<leader>s', ':setlocal spell!<CR>', {})

-- markdown table alignment (cursor must be inside table, table must be isolated paragraph)
vim.keymap.set('n', '<leader>t', 'gaiptm <CR>s|<CR>jV:s/ /-/g<CR>:noh<CR>', { remap = true })
