return {
	{
		"nvim-mini/mini.pick",
		enabled = true,
		dependencies = "nvim-mini/mini.icons",
		config = function(_, opts)
			require("mini.pick").setup(opts)
			vim.ui.select = require("mini.pick").ui_select
		end,
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
