return {
	{
		"nvim-mini/mini.pick",
		enabled = true,
		dependencies = "nvim-mini/mini.icons",
		keys = {
			{
				"<leader>f",
				function()
					require("mini.pick").builtin.files()
				end,
				desc = "Find files",
			},
			{
				"<leader>/",
				function()
					require("mini.pick").builtin.grep_live()
				end,
				desc = "Grep workspace",
			},
			{
				"<leader>b",
				function()
					require("mini.pick").builtin.buffers()
				end,
				desc = "Find buffers",
			},
		},
	},
}
