vim.g.skip_ts_context_commentstring_module = true
require "nvim-treesitter.configs".setup 
{
    ensure_installed = { "c", "cpp", "cmake", "comment", "gitignore", "lua", "markdown" }, 
    
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = { enable = true },

    autotag = { enable = true },
    indent = { enable = true }
}
