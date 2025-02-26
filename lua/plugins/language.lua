-- Declare LSP servers and formatters to install

local lsp_servers = {
	-- server_name = {
	--   cmd = {},
	--   filetypes = {},
	--   capabilities = {},
	--   settings = {},
	--   on_init = function(client) end,
	-- },
	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				diagnostics = {
					disable = { "missing-fields" },
				},
			},
		},
	},
	pyright = {
		settings = {
			python = {
				analysis = {
					typeCheckingMode = "off",
				},
			},
		},
	},
	texlab = {},
	marksman = {},
	gopls = {},
	rust_analyzer = {},
	html = {},
}

local formatters = {
	"stylua",
	"ruff",
	"prettierd",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- set .configs as module to run opts on
		opts = {
			auto_install = true,
			highlight = {
				enable = true,
				disable = function(_, buf)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end
				end,
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		config = true,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = {
			{ "williamboman/mason.nvim", lazy = false, config = true },
		},
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, vim.tbl_keys(lsp_servers))
			vim.list_extend(opts.ensure_installed, formatters)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = {
			{ "williamboman/mason.nvim", lazy = false, config = true },
			{ "neovim/nvim-lspconfig", lazy = false },
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = function(_, opts)
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			opts.handlers = opts.handlers or {}
			table.insert(opts.handlers, function(server_name)
				local server_settings = lsp_servers[server_name] or {}
				server_settings.capabilities =
					vim.tbl_deep_extend("force", {}, capabilities, server_settings.capabilities or {})
				require("lspconfig")[server_name].setup(server_settings)
			end)
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_format" },
				markdown = { "prettierd" },
			},
			format_on_save = {
				-- I recommend these options. See :help conform.format for details.
				lsp_format = "fallback",
				timeout_ms = 500,
			},
		},
	},
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
