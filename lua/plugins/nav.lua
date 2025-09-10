return {
	{
		"nvim-mini/mini.pick",
		enabled = true,
		dependencies = { "nvim-mini/mini.icons", "nvim-mini/mini.extra" },
		config = function(_, opts)
			require("mini.pick").setup(opts)
			vim.ui.select = function(items, select_opts, on_choice)
				local start_opts = { window = { config = { height = #items } } }
				return require("mini.pick").ui_select(items, select_opts, on_choice, start_opts)
			end
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
			{
				"gr",
				function()
					require("mini.extra").pickers.lsp({ scope = "references" })
				end,
				desc = "Go to references",
			},
		},
	},
}
