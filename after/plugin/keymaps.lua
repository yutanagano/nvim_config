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
	local convert_to_html = "pandoc --from markdown --to html"
	local remove_hyperlinks_opening = "sed -z 's/<a[^>]*>//g'"
	local remove_hyperlinks_closing = "sed -z 's/<\\/a>//g'"
	local set_to_formatted_clipboard = "wl-copy --type text/html"

	local transformed_text = vim.fn.system(remove_underscores, selected_text)
	transformed_text = vim.fn.system(remove_opening_braces, transformed_text)
	transformed_text = vim.fn.system(remove_closing_braces, transformed_text)
	transformed_text = vim.fn.system(convert_to_html, transformed_text)
	transformed_text = vim.fn.system(remove_hyperlinks_opening, transformed_text)
	transformed_text = vim.fn.system(remove_hyperlinks_closing, transformed_text)

	vim.fn.system(set_to_formatted_clipboard, transformed_text)
end, {
	noremap = true,
	silent = true,
	desc = "Converts highlighted markdown into formatted html and saves to system clipboard",
})

-- spelling
local function add_to_user_dict(word)
	local spellfile_path = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
	vim.ui.select(
		{ "Yes", "No" },
		{ prompt = 'Would you like to add "' .. word .. '" to your user dictionary?' },
		function(choice)
			if choice == "Yes" then
				local spellfile = io.open(spellfile_path, "a")
				if spellfile then
					spellfile:write(word)
					spellfile:close()
				else
					vim.notify("User spellfile not found.", vim.log.levels.ERROR)
					return
				end

				local sorted = vim.fn.system("sort " .. spellfile_path .. " | uniq")
				spellfile = io.open(spellfile_path, "w")
				if spellfile then
					spellfile:write(sorted)
					spellfile:close()
				end

				vim.cmd("silent mkspell! " .. spellfile_path)
				vim.cmd("silent! call spellreload()")
			end
		end
	)
end

vim.keymap.set("n", "<leader>s", ":setlocal spell!<CR>", { desc = "Toggle spelling" })
vim.keymap.set("n", "zs", "1z=", { desc = "Replace spelling with top suggestion" })
vim.keymap.set("n", "zg", function()
	vim.cmd("normal! yiw")
	local word = vim.fn.getreg('"')
	add_to_user_dict(word)
end)
vim.keymap.set("x", "zg", function()
	vim.cmd("normal! y")
	local word = vim.fn.getreg('"')
	add_to_user_dict(word)
end)

-- LSP
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Get LSP hover" })
