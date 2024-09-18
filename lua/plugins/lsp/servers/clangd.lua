local handler = require "plugins.lsp.handler"
local clangd_ext_handler = require "lsp-status".extensions.clangd.setup {}
return function(on_attach)
    return 
    {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.server_capabilities.document_formatting = true
		 client.server_capabilities.document_range_formatting = true
        end,
        cmd = {
            "clangd",
            "--background-index",
	       "-j=12",
	       "--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
	       "--clang-tidy",
	       "--clang-tidy-checks=*",
	       "--all-scopes-completion",
	       "--cross-file-rename",
	       "--completion-style=detailed",
	       "--header-insertion-decorators",
	       "--header-insertion=iwyu",
	       "--pch-storage=memory"
	   },
	   handlers = handler.with { clangd_ext_handler },
	   filetypes = { "c", "cpp", "cuda", "proto", "cc" },
	   init_options = {
		  clangdFileStatus = true,
		  usePlaceholders = true,
		  completeUnimported = true,
		  semanticHighlightings = true
        }
    }
end
