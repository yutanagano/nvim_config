local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    print("nvim-tree not found!")
    return
end

nvim_tree.setup({
    disable_netrw = true,
    hijack_netrw = true,
})

-- keybindings
local api = require("nvim-tree.api")
vim.keymap.set("n", "<leader>e", api.tree.toggle, opts)
