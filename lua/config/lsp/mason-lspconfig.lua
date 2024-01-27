require "mason-lspconfig".setup 
{
    ensure_installed = 
    { 
        "marksman", 
        "diagnosticls", 
        "clangd", 
        "cmake", 
        "lua_ls"
    }
}
