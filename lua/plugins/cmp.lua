return {
	"tpope/vim-sleuth",
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
					config = function(_, opts)
						require("luasnip").setup(opts)
						require("luasnip/loaders/from_vscode").lazy_load()
					end,
				},
			},
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-path",
		},
		opts = function(_, opts)
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			opts.snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
				end,
			}

			opts.window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			}

			opts.preselect = cmp.PreselectMode.None

			opts.mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
				["<C-e>"] = cmp.mapping.abort(),
			})

			opts.sources = cmp.config.sources({
				{ name = "lazydev", group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions
				{ name = "luasnip", group_index = 1 },
				{
					name = "nvim_lsp",
					group_index = 1,
					option = { markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]] } },
				},
				{ name = "path", group_index = 1 },
				{ name = "copilot", group_index = 2 },
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},
	"bullets-vim/bullets.vim",
}
