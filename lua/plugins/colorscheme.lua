return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = function(_, opts)
			opts.colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			}
			opts.overrides = function(colors)
				local theme = colors.theme
				return {
					["@markup.list.markdown"] = { fg = theme.syn.special2 },
					["@markup.heading.markdown"] = { fg = theme.syn.identifier, bold = true },
					["@markup.heading.2.markdown"] = { fg = theme.syn.identifier, bold = true },
					["@markup.heading.3.markdown"] = { fg = theme.syn.string, bold = true },
					["@markup.heading.4.markdown"] = { fg = theme.syn.type, bold = true },
					["@lsp.type.decorator.markdown"] = { fg = theme.syn.special1 },
					LineNr = { fg = theme.ui.nontext },
					CursorLineNr = { fg = theme.syn.constant },
				}
			end
		end,
		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd("colorscheme kanagawa")
		end,
	},
}
