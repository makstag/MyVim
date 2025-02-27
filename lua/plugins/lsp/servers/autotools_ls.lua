local util = require("lspconfig.util")
local root_files = { "configure.ac", "Makefile", "Makefile.am", "*.mk" }

return function(on_attach)
	return 
	{
	    on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                client.server_capabilities.document_formatting = true
	        client.server_capabilities.document_range_formatting = true
            end,
	    cmd = { "autotools-language-server" },
	    filetypes = { "config", "automake", "make" },
	    root_dir = function(fname)
	        return util.root_pattern(unpack(root_files))(fname)
	    end,
	    single_file_support = true
	}
end

