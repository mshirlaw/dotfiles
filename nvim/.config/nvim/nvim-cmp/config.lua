local cmp = require'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                end
                cmp.confirm()
            else
                fallback()
            end
        end, {"i","s","c",}),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable, 
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'ultisnips' }, 
        }, 
        {
            { name = 'buffer' },
        }
    )
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources(
        {
            { name = 'path' }
        }, 
        {
            { name = 'cmdline' }
        }
    )
})

-- Setup lspconfig.

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')[ "tsserver" ].setup {
    capabilities = capabilities
}

require('lspconfig')[ "bashls" ].setup {
    capabilities = capabilities
}

require('lspconfig')[ "jsonls" ].setup {
    capabilities = capabilities
}

require('lspconfig')[ "html" ].setup {
    capabilities = capabilities
}

require('lspconfig')[ "cssls" ].setup {
    capabilities = capabilities
}

require('lspconfig')[ "vimls" ].setup {
    capabilities = capabilities
}

require('lspconfig')[ "yamlls" ].setup {
    capabilities = capabilities
}
