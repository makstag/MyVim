local mason = require "mason"
local masonlsp = require "mason-lspconfig"
local lspconfig = require "lspconfig"

-- 1. Set up mason-lspconfig first!
mason.setup {}
masonlsp.setup {
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
    },
    automatic_installation = true,
}

-- 2. (optional) Override the default configuration to be applied to all servers.
local lsp_flags = {
    debounce_text_changes = 150,
}

lspconfig.util.default_config = vim.tbl_extend(
    "force",
    lspconfig.util.default_config,
    {
        on_attach = require"config.lsp.handlers".on_attach,
        capabilities = require"config.lsp.handlers".capabilities,
        flags = lsp_flags
    }
)

-- 3. Loop through all of the installed servers and set it up via lspconfig
for _, server in ipairs(masonlsp.get_installed_servers()) do
  lspconfig[server].setup {}
end