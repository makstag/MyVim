local util = require("lspconfig.util")
local root_files = { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake" }
return function(on_attach)
    return 
    {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.server_capabilities.document_formatting = true
	    client.server_capabilities.document_range_formatting = true
        end,
        cmd = { "cmake-language-server" },
        filetypes = { "cmake" },
        root_dir = function(fname)
            return util.root_pattern(unpack(root_files))(fname)
        end,
        single_file_support = true,
        init_options = { buildDirectory = "build" },

        root_dir = [[root_pattern("CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake")]]
    }
end
