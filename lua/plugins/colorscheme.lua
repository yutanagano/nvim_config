return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = function(_, opts)
			local dragon_colors = require("kanagawa.colors").setup({ theme = "dragon" })
			opts.colors = {
				theme = {
					dragon = {
						ui = {
							fg = dragon_colors.palette.fujiWhite,
							float = {
								fg = dragon_colors.palette.fujiWhite,
								bg = dragon_colors.theme.ui.bg,
								bg_border = dragon_colors.theme.ui.bg,
							},
							pmenu = {
								fg = dragon_colors.palette.fujiWhite,
								bg = dragon_colors.theme.ui.bg,
								bg_sel = dragon_colors.theme.ui.bg_p2,
							},
						},
					},
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
					-- BlinkCmpMenuBorder = { link = "FloatBorder" },
				}
			end
		end,
		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
}
