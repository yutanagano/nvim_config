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
							float = {
								bg = dragon_colors.theme.ui.bg,
								bg_border = dragon_colors.theme.ui.bg,
							},
							pmenu = {
								bg = dragon_colors.theme.ui.bg,
								bg_sel = dragon_colors.theme.ui.bg_p2,
							},
						},
					},
					-- all = {
					-- 	ui = {
					-- 		bg_gutter = "none",
					-- 	},
					-- },
				},
			}
		end,
		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
}
