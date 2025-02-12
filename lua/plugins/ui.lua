return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function(_, opts)
			opts.extensions = opts.extensions or {}
			opts.extensions["ui-select"] = {
				require("telescope.themes").get_cursor(),
			}
			require("telescope").setup(opts)
			require("telescope").load_extension("ui-select")
		end,
	},
}
