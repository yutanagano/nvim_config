-- bootstrap lazy.nvim
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

-- install plugins with lazy.nvim
local plugins = {
    "folke/lazy.nvim",
    "nvim-lua/plenary.nvim",
    {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
    },
    {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
    },

    -- LSP
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
    },
    {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
    },

    {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
	    "nvim-tree/nvim-web-devicons",
	},
    },
}

local lazy = require("lazy")
lazy.setup(plugins)
