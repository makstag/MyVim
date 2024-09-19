return
{
    "neovim/nvim-lspconfig",
    dependencies = {
	    "williamboman/mason-lspconfig.nvim",
	    "williamboman/mason.nvim",
	    "nvim-lua/lsp-status.nvim",
	    "nvimdev/lspsaga.nvim",
	    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	    "ray-x/lsp_signature.nvim"
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("mason").setup({})
        require("lsp_lines").setup({})
        local handler = require("plugins.lsp.handler")
        
        handler.setup({})
        local on_attach = handler.on_attach
        local capabilities = handler.capabilitie

        local servers = {
            clangd = require("plugins.lsp.servers.clangd")(on_attach), 
            cmake = require("plugins.lsp.servers.cmake")(on_attach), 
            asm_lsp = require("plugins.lsp.servers.asm_lsp")(on_attach)
        }

        local default_lsp_config = {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = { debounce_text_changes = 200, allow_incremental_sync = true }
        }

        local server_names = {}
        local server_configs = {}
        for server_name, server_config in pairs(servers) do
            table.insert(server_names, server_name)
            server_configs[server_name] = server_config
        end

        local lspconfig = require("lspconfig")
        local mason = require("mason-lspconfig")
        mason.setup({ ensure_installed = server_names, automatic_installation = true })
        mason.setup_handlers({ function(server)
            local merged_config = vim.tbl_deep_extend("force", default_lsp_config, server_configs[server] or {})
            lspconfig[server].setup(merged_config)
        end })
    end
}
