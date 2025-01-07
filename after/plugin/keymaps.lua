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
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, {})

-- yanking and pasting
vim.keymap.set('', '<leader>y', '"+y', {})
vim.keymap.set('n', '<leader>p', '"+p', {})

-- spelling
vim.keymap.set('n', '<leader>s', ':setlocal spell!<CR>', {})

-- markdown table alignment (cursor must be inside table, table must be isolated paragraph)
vim.keymap.set('n', '<leader>t',
  'vip'.. -- select current paragraph
  ':! sed -E "s/-+/-/g"'.. -- replace consecutive dashes with one (make header delimiter line as short as possible)
  '| sed -E "s/\\| +/\\| /g"'..
  '| sed -E "s/ +\\|/ \\|/g"'.. -- above two lines remove any unnecessary spaces between column delimiters
  '| column -t -s "|" -o "|"<CR>'.. -- columnise / align markdown table
  'j:s/ /-/g<CR>:noh<CR>k' -- fill header delimiter line back up with dashes
, {})
