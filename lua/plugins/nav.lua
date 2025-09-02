return {
	{
		"nvim-telescope/telescope.nvim",
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
		keys = {
			{
				"<leader>f",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},
			{
				"<leader>g",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "Find git files",
			},
			{
				"<leader>/",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Grep workspace",
			},
			{
				"<leader>b",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find buffers",
			},
			{
				"<leader>d",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "List diagnostics",
			},
			{
				"gd",
				function()
					require("telescope.builtin").lsp_definitions()
				end,
				desc = "Go to definition(s)",
			},
			{
				"gr",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "Go to reference(s)",
			},
		},
	},
}
