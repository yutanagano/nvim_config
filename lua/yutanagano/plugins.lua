-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins with lazy.nvim
local plugins = {
    "folke/lazy.nvim",
    "nvim-lua/plenary.nvim",
    {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
    }
}

local lazy = require("lazy")
lazy.setup(plugins)
