local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    print("nvim-treesitter not found!")
    return
end

configs.setup({
    ensure_installed = { "c", "lua", "rust", "python" },
    sync_install = false,
    highlight = { enable = true },
})
