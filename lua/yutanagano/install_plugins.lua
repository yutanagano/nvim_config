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
    -- ensure lazy.nvim is up to date
    "folke/lazy.nvim",

    -- parsing
    {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
    },

    -- better file navigation
    {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
	    "nvim-lua/plenary.nvim",
	},
    },
    {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
	    "nvim-tree/nvim-web-devicons",
	},
    },
    {
	'romgrk/barbar.nvim',
	dependencies = {
	    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
	    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
	},
	init = function() vim.g.barbar_auto_setup = false end,
	opts = {
	    -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
	    -- animation = true,
	    -- insert_at_start = true,
	    -- …etc.
	}
    },

    -- cmp
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {},
    },
    "dkarter/bullets.vim",

    -- snippets
    "L3MON4D3/LuaSnip",

    -- lsp
    {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v3.x',
	dependencies = {
	    "neovim/nvim-lspconfig",
	    "hrsh7th/cmp-nvim-lsp",
	    "williamboman/mason.nvim",
	    "williamboman/mason-lspconfig.nvim",
	},
    },

    -- colorschemes
    {
	"ellisonleao/gruvbox.nvim",
	priority = 1000
    },

    -- other 
    {
	"akinsho/toggleterm.nvim",
	version = "v2.*",
	config = true,
    },
}

local lazy = require("lazy")
lazy.setup(plugins)
