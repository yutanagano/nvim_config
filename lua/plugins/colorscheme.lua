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
		end,
		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd("colorscheme kanagawa-dragon")
		end,
	},
}
