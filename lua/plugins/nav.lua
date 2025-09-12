return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		dependencies = { "nvim-mini/mini.icons" },
		lazy = false,
	},
	{
		"nvim-mini/mini.pick",
		lazy = false,
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
				"<leader>g",
				function()
					require("mini.extra").pickers.git_files()
				end,
				desc = "Find git files",
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
				"gd",
				function()
					local function on_list(opts)
						vim.fn.setqflist({}, " ", opts)

						if #opts.items == 1 then
							vim.cmd.cfirst()
						else
							require("mini.extra").pickers.list(
								{ scope = "quickfix" },
								{ source = { name = opts.title } }
							)
						end
					end
					vim.lsp.buf.definition({ on_list = on_list })
				end,
				desc = "Go to definition",
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
