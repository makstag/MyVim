vim.g.skip_ts_context_commentstring_module = true
local configs = require "nvim-treesitter.configs"
configs.setup 
{
    ensure_installed = { "c", "cpp", "cmake", "comment", "gitignore", "lua", "markdown" }, 
    
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = { enable = true },

    autotag = { enable = true },
    indent = { enable = false }
}

require "nvim-treesitter.parsers".get_parser_configs().caddy = 
{
    install_info = 
    {
        url = "https://github.com/Samonitari/tree-sitter-caddy",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
    },
    filetype = "caddy"
}

vim.list_extend(configs.ensure_installed, { "caddy" })
vim.filetype.add({ pattern = { ["Caddyfile"] = "caddy" } })