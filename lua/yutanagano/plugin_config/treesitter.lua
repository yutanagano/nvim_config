local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = { "c", "lua", "rust", "python" },
    sync_install = false,
    highlight = { enable = true },
})
