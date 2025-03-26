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
		keys = {
			{
				"<leader>f",
				require("telescope.builtin").find_files,
				desc = "Find files",
			},
			{
				"<leader>g",
				require("telescope.builtin").git_files,
				desc = "Find git files",
			},
			{
				"<leader>/",
				require("telescope.builtin").live_grep,
				desc = "Grep workspace",
			},
			{
				"<leader>b",
				require("telescope.builtin").buffers,
				desc = "Find buffers",
			},
			{
				"<leader>d",
				require("telescope.builtin").diagnostics,
				desc = "List diagnostics",
			},
			{
				"gd",
				require("telescope.builtin").lsp_definitions,
				desc = "Go to definition(s)",
			},
			{
				"gr",
				require("telescope.builtin").lsp_references,
				desc = "Go to reference(s)",
			},
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				char = {
					enabled = false,
				},
			},
		},
		keys = {
			{
				"<leader>j",
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
		},
	},
}
