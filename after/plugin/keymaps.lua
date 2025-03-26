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
vim.keymap.set("", "<leader>y", '"+y', { desc = "Yank to clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- spelling
vim.keymap.set("n", "<leader>s", ":setlocal spell!<CR>", { desc = "Toggle spelling" })
vim.keymap.set("n", "zs", "1z=", { desc = "Replace spelling with top suggestion" })

-- ui
vim.keymap.set("n", "<leader>c", function()
	local current_bg = vim.o.background or "dark"

	if current_bg == "dark" then
		vim.o.background = "light"
		return
	end

	vim.o.background = "dark"
end, { desc = "Toggle dark / light mode" })
