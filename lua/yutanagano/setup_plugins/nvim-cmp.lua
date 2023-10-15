local status_ok, cmp = pcall(require, "cmp")
if not status_ok then
    print("nvim-cmp not found!")
    return
end

local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
    print("luasnip not found!")
    return
end

cmp.setup({
    snippet = {
	-- REQUIRED - you must specify a snippet engine
	expand = function(args)
	    luasnip.lsp_expand(args.body) -- For `luasnip` users.
	end,
    },
    mapping = cmp.mapping.preset.insert({
	["<C-j>"] = cmp.mapping.select_next_item(),
	["<C-k>"] = cmp.mapping.select_prev_item(),
	['<C-b>'] = cmp.mapping.scroll_docs(-1),
	['<C-f>'] = cmp.mapping.scroll_docs(1),
	['<C-Space>'] = cmp.mapping.complete(),
	['<C-e>'] = cmp.mapping.abort(),
	['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
	{ name = "nvim_lsp" },
	{ name = 'luasnip' }, -- For luasnip users.
	{ name = 'buffer' },
	{ name = "path" },
    }),
    formatting = {
	format = function(entry, vim_item)
	    vim_item.menu = ({
		nvim_lsp = "[lsp]",
		buffer = "[buffer]",
		path = "[path]",
	    })[entry.source.name]
	    return vim_item
	end
    },
})
