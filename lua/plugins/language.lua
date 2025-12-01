-- Declare LSP servers and formatters to install

local lsp_servers = {
	-- server_name = {
	--   cmd = {},
	--   filetypes = {},
	--   capabilities = {},
	--   settings = {},
	--   on_init = function(client) end,
	-- },
	["lua-language-server"] = {
		alt = "lua_ls",
		opts = {
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
	},
	pyright = {
		opts = {
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "off",
					},
				},
			},
		},
	},
	texlab = {},
	["markdown-oxide"] = {
		alt = "markdown_oxide",
		opts = {
			capabilities = {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			},
		},
	},
	gopls = {},
	["rust-analyzer"] = {
		alt = "rust_analyzer",
	},
	superhtml = {},
	["typescript-language-server"] = {
		alt = "ts_ls",
	},
	["css-lsp"] = {
		alt = "cssls",
	},
	tinymist = {},
	clangd = {},
	esbonio = { no_install = true },
}

local formatters = {
	"stylua",
	"ruff",
	"prettierd",
	"typstyle",
	"taplo",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function(_, _)
			local languages = {
				"python",
				"lua",
				"c",
				"rust",
				"go",
				"markdown",
				"latex",
				"typst",
				"toml",
				"yaml",
				"rst",
			}
			require("nvim-treesitter").install(languages)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = languages,
				callback = function()
					vim.treesitter.start()
				end,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = {
			{ "williamboman/mason.nvim", lazy = false, config = true },
		},
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}

			for server_name, server_opts in pairs(lsp_servers) do
				if server_opts.no_install == nil or not server_opts.no_install then
					table.insert(opts.ensure_installed, server_name)
				end
			end

			vim.list_extend(opts.ensure_installed, formatters)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},
		config = function()
			for server_name, server_settings in pairs(lsp_servers) do
				server_name = server_settings.alt or server_name
				server_settings = server_settings.opts or {}
				server_settings.capabilities = require("blink.cmp").get_lsp_capabilities(server_settings.capabilities)
				vim.lsp.config(server_name, server_settings)
				vim.lsp.enable(server_name)
			end
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
				typst = { "typstyle" },
				javascript = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				toml = { "taplo" },
			},
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = {
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
				"${3rd}/busted/library",
				"${3rd}/luassert/library",
			},
		},
	},
}
