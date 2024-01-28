local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local check_back_space = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline ".":sub(col, col):match "%s" ~= nil
end

local kind_icons = 
{
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

cmp.setup 
{
    enabled = 
    {
        function()
            return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"  or require "cmp_dap".is_dap_buffer()        
        end
    },
    snippet = 
    {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- import `luasnip` engine
        end,
    },
    mapping = 
    {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close(), },
        ["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            elseif check_back_space() then
                fallback()
            else
                fallback()
            end
        end, { "i", "s", }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s", }),
    },
    formatting = 
    {
        -- Youtube: How to set up nice formatting for your sources.
        format = lspkind.cmp_format 
        {
            mode = "symbol_text",
            max_width = 50,
            with_text = true,
            ellipsis_char = '...',
            before = function (entry, vim_item)
                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                vim_item.menu = 
                {
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[Lua]",
                    path = "[Path]",
                    luasnip = "[LuaSnip]",
                    gh_issues = "[Issues]",
                    tn = "[TabNine]",
                    eruby = "[erb]",
                } [entry.source.name]
                return vim_item
            end
        }
    },
    sources = 
    {
        { name = "nvim_lsp" }, { name = "buffer" }, { name = "luasnip" },
        { name = "nvim_lua" }, 
        { name = "path" }, 
        { name = "tn" },
        { name = "eruby" }, { name = "gh_issues" }
    },
    completion = {completeopt = 'menu,menuone,noselect,noinsert'},
    confirm_opts = 
    {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = { documentation = cmp.config.window.bordered() },
    experimental = 
    {
        ghost_text = false,
        view = { entries = "native_menu" }
    },
}

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', 
{
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, 
        { { name = 'cmdline' } })
})

cmp.setup.cmdline('/', 
{                                  
    view = { entries = {name = 'wildmenu', separator = '|' } }                                             
})                                                        

cmp.setup.filetype({ "TelescopePrompt", "dap-repl", "dapui_watches", "dapui_hover" }, 
{
    enabled = false,
    sources = { { name = "dap" } },
})

-- TabNine
local tabnine = require "cmp_tabnine.config"
tabnine:setup({max_lines = 1000, max_num_results = 20, sort = true})
