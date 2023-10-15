local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    print("toggelterm not found")
    return
end

toggleterm.setup({
    open_mapping = [[<c-\>]],
    insert_mappings = true,
    hide_numbers = true,
    direction = "float",
})
