vim.cmd.colorscheme("default")

local my_colorscheme = "catppuccin"

local status_ok, _ = pcall(vim.cmd.colorscheme, my_colorscheme)
if not status_ok then
    print(my_colorscheme .. " (colorscheme) not found!")
    return
end
