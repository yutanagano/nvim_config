-- ui
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "100"
vim.opt.scrolloff = 5

-- indent
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.g.python_indent = {
	open_paren = "shiftwidth()",
	closed_paren_align_last_line = false,
}
vim.g.markdown_recommended_style = false -- prevents markdown indent being overriden to 4 spaces

-- spelling
vim.opt.spelllang = { "en" }

-- fuzzy search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- bullets.nvim
vim.g.bullets_outline_levels = { "num", "std-" }
