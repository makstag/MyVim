require "ts_context_commentstring".setup 
{
    enable_autocmd = false
}

vim.g.skip_ts_context_commentstring_module = true
local treesitter = require "nvim-treesitter"

treesitter.setup 
{
    ensure_installed = { "c", "cpp", "cmake", "comment", "gitignore", "lua", "markdown" }, 
    highlight = 
    {
        enable = true, 
        additional_vim_regex_highlighting = false
    },
    sync_install = false,
    auto_install = true,
    indent = { enable = false -- default is disabled anyways },

    autotag = { enable = true }
}

-- 开启 Folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99
