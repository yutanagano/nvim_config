return {
	"tpope/vim-sleuth",
	{
		"yutanagano/smark.nvim",
		ft = { "markdown", "text" },
		config = true,
	},
	-- { dir = "~/Projects/smark.nvim", config = true },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"saghen/blink.cmp",
		dependencies = { "L3MON4D3/LuaSnip" },
		version = "1.*",
		opts = {
			appearance = {
				kind_icons = {
					Text = "Txt",
					Method = "Met",
					Function = "Fun",
					Constructor = "Con",

					Field = "Fld",
					Variable = "Var",
					Property = "Pro",

					Class = "Cls",
					Interface = "Int",
					Struct = "Str",
					Module = "Mod",

					Unit = "Unt",
					Value = "Val",
					Enum = "Enu",
					EnumMember = "Enm",

					Keyword = "Kwd",
					Constant = "Cst",

					Snippet = "Snp",
					Color = "Clr",
					File = "Fil",
					Reference = "Ref",
					Folder = "Dir",
					Event = "Evt",
					Operator = "Opr",
					TypeParameter = "Typ",
				},
			},
			keymap = {
				preset = "default",
				["<Tab>"] = {},
				["<C-l>"] = { "snippet_forward" },
				["<C-h>"] = { "snippet_backward" },
			},
			completion = {
				documentation = {
					auto_show = true,
				},
			},
			sources = {
				default = { "lsp", "path", "snippets" },
			},
			snippets = { preset = "luasnip" },
			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
		},
		opts_extend = { "sources.default" },
	},
}
