return {
	"tpope/vim-sleuth",
	{ "bullets-vim/bullets.vim", enabled = false },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
					config = function(_, opts)
						require("luasnip").setup(opts)
						require("luasnip/loaders/from_vscode").lazy_load()
					end,
				},
			},
		},
		version = "1.*",
		opts = {
			keymap = {
				preset = "default",
				["<Tab>"] = {},
				["<C-l>"] = { "snippet_forward" },
				["<C-h>"] = { "snippet_backward" },
			},
			completion = {
				documentation = {
					auto_show = true,
					window = { border = "rounded" },
				},
				menu = { border = "rounded" },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			snippets = { preset = "luasnip" },
			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
		},
		opts_extend = { "sources.default" },
	},
}
