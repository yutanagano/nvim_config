require("nvim-treesitter.configs").setup({
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
   }
})

require("mason").setup()
require("mason-lspconfig").setup({
   ensure_installed = { "pylsp", "texlab", "marksman", "lua_ls", "gopls" },
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.pylsp.setup({
   capabilities = capabilities,
   settings = {
      pylsp = {
	 plugins = {
	    rope_autoimport = { enabled = true },
	    pycodestyle = {
	       ignore = { "E501", "E226", "E203", "W503" }
	    },
	 },
      }
   }
})
lspconfig.texlab.setup({
   capabilities = capabilities
})
lspconfig.marksman.setup({
   capabilities = capabilities
})
lspconfig.lua_ls.setup({
   capabilities = capabilities,
   on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
	 return
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
	 runtime = {
	    -- Tell the language server which version of Lua you're using
	    -- (most likely LuaJIT in the case of Neovim)
	    version = 'LuaJIT'
	 },
	 -- Make the server aware of Neovim runtime files
	 workspace = {
	    checkThirdParty = false,
	    library = {
	       vim.env.VIMRUNTIME
	       -- Depending on the usage, you might want to add additional paths here.
	       -- "${3rd}/luv/library"
	       -- "${3rd}/busted/library",
	    }
	    -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
	    -- library = vim.api.nvim_get_runtime_file("", true)
	 }
      })
   end,
   settings = {
      Lua = {}
   }
})
lspconfig.gopls.setup({})
