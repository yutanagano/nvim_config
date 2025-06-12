-- This document sets up keymaps that make use of vanilla neovim functions.
-- See lazy plugin files for plugin-based keymaps.

-- navigation
vim.keymap.set("n", "gl", ":bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "gh", ":bprev<CR>", { desc = "Go to previous buffer" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "gl", ":bnext<CR>", { buffer = true })
		vim.keymap.set("n", "gh", ":bprev<CR>", { buffer = true })
	end,
})

-- language and refactoring
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Expand diagnostics" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code action" })

-- yanking and pasting
vim.keymap.set("x", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("x", "<leader>my", function()
	vim.cmd("normal! y")
	local selected_text = vim.fn.getreg('"')

	local remove_underscores = "sed 's/_/ /g'"
	local remove_opening_braces = "sed 's/\\[\\[//g'"
	local remove_closing_braces = "sed 's/\\]\\]//g'"

	local transformed_text = vim.fn.system(remove_underscores, selected_text)
	transformed_text = vim.fn.system(remove_opening_braces, transformed_text)
	transformed_text = vim.fn.system(remove_closing_braces, transformed_text)

	vim.fn.setreg("+", transformed_text)
end, {
	noremap = true, -- Prevents the mapping from being remapped recursively.
	silent = true, -- Suppresses the command from being echoed on the command line.
	desc = "Cleans away markdown decorations and copies to system clipboard",
})

-- spelling
vim.keymap.set("n", "<leader>s", ":setlocal spell!<CR>", { desc = "Toggle spelling" })
vim.keymap.set("n", "zs", "1z=", { desc = "Replace spelling with top suggestion" })

-- LSP
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Get LSP hover" })
