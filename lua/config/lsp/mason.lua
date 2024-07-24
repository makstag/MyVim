-- Default configuration https://github.com/williamboman/mason.nvim#default-configuration
require "mason".setup {}

require "mason-lspconfig".setup 
{
    ensure_installed = 
    { 
        "marksman", 
        "diagnosticls", 
        "clangd", 
        "cmake", 
        "lua_ls",
        "autotools_ls@0.0.20",
        "asm_lsp"
    },
    automatic_installation = true
}
