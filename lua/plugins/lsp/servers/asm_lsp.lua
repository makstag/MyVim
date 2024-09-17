local util = require "lspconfig.util"
return function(on_attach)
    return 
    {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
		 client.server_capabilities.document_formatting = false
		 client.server_capabilities.document_range_formatting = false
        end,
        cmd = { "asm-lsp" },
        filetypes = { "asm", "vmasm", "s", "S" },
        root_dir = util.find_git_ancestor
    }
end