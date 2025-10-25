return {
	{
		"webhooked/kanso.nvim",
		lazy = false,
		priority = 1000,
		config = function(_, opts)
			opts = opts or {}
			opts.background = {
				dark = "zen",
				light = "pearl",
			}
			require("kanso").setup(opts)
			vim.cmd("colorscheme kanso")
		end,
		keys = {
			{
				"<leader>c",
				function()
					if vim.o.background == "light" then
						vim.opt.background = "dark"
					else
						vim.opt.background = "light"
					end
				end,
			},
		},
	},
}
