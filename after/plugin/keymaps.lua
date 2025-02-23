local builtin = require("telescope.builtin")

-- navigation
vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>g", builtin.git_files, { desc = "Find git files" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Grep workspace" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Find buffers" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to definition(s)" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Go to reference(s)" })
vim.keymap.set("n", "gl", ":bnext<CR>", { desc = "Go to next buffer" })
vim.keymap.set("n", "gh", ":bprev<CR>", { desc = "Go to previous buffer" })
vim.keymap.set("n", "gj", "<c-d>zz", { desc = "Scroll down" })
vim.keymap.set("n", "gk", "<c-u>zz", { desc = "Scroll up" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "gl", ":bnext<CR>", { buffer = true })
		vim.keymap.set("n", "gh", ":bprev<CR>", { buffer = true })
	end,
})

-- language and refactoring
vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "List diagnostics" })
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

-- markdown table alignment (cursor must be inside table, table must be isolated paragraph)
vim.keymap.set(
	"n",
	"<leader>t",
	"vip" -- select current paragraph
		.. ':! sed -E "s/-+/-/g"' -- replace consecutive dashes with one (make header delimiter line as short as possible)
		.. '| sed -E "s/ *\\| */ \\| /g"' -- remove any unnecessary spaces around column delimiters
		.. '| sed -E "s/^ //g"' -- remove space at beginning of line
		.. '| sed -E "s/ $//g"' -- remove space at end of line
		.. '| column -t -s "|" -o "|"<CR>' -- columnise / align markdown table
		.. "j:s/ /-/g<CR>:noh<CR>k", -- fill header delimiter line back up with dashes
	{ desc = "Auto-format markdown table" }
)
