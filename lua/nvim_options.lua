-- ui
vim.opt.number = true
vim.opt.scrolloff = 10
vim.diagnostic.config({ float = { border = "rounded" } })
-- vim.opt.winborder = "rounded"
-- vim.opt.cursorline = true

-- indent
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.g.python_indent = {
	open_paren = "shiftwidth()",
	closed_paren_align_last_line = false,
}

-- spelling
vim.opt.spelllang = { "en" }
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "latex" },
	callback = function()
		vim.opt_local.spell = true
		-- vim.opt_local.textwidth = textwidth
	end,
})

-- fuzzy search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- bullets.nvim
vim.g.bullets_outline_levels = { "num", "std-" }
