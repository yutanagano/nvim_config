local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
   snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
	 require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
	 -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
   },
   window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
   },
   mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping(function(fallback)
	 if cmp.visible() then
	    if luasnip.expandable() then
	       luasnip.expand()
	    else
	       cmp.confirm({
		  select = true,
	       })
	    end
	 else
	    fallback()
	 end
      end),

      ["<Tab>"] = cmp.mapping(function(fallback)
	 if cmp.visible() then
	    cmp.select_next_item()
	 elseif luasnip.locally_jumpable(1) then
	    luasnip.jump(1)
	 else
	    fallback()
	 end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
	 if cmp.visible() then
	    cmp.select_prev_item()
	 elseif luasnip.locally_jumpable(-1) then
	    luasnip.jump(-1)
	 else
	    fallback()
	 end
      end, { "i", "s" }),
   }),
   sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
   })
})
