require "mason-lspconfig".setup {
    ensure_installed = { 
        "pylsp", 
        "dockerls", 
        "bashls", 
        "marksman", 
        "docker_compose_language_service", 
        "diagnosticls", 
        "clangd", 
        "neocmake", 
        "lua_ls",  
        "jsonls", 
        "yamlls" 
    }
}
