return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
		ft = { "markdown" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			checkbox = {
				bullet = true,
				unchecked = { icon = " 󰄱 " },
				checked = { icon = " 󰱒 " },
			},
		},
	},
}
