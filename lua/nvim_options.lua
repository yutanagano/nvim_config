vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "100"
vim.opt.scrolloff = 5

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.spelllang = {"en_gb"}

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- python
vim.g.python_indent = {
  open_paren = 'shiftwidth()',
  closed_paren_align_last_line = false
}
