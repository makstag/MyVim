-- Default configuration https://github.com/williamboman/mason.nvim#default-configuration
require "mason".setup{}

require "mason-lspconfig".setup 
{
    ensure_installed = 
    { 
        "marksman", 
        "diagnosticls", 
        "clangd", 
        "cmake", 
        "lua_ls"
    },
    automatic_installation = true
}
