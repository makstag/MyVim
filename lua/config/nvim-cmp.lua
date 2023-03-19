-- nvim-cmp setup
local cmp = require "cmp"
local luasnip = require "luasnip"

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

local check_back_space = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline ".":sub(col, col):match "%s" ~= nil
end

cmp.setup {
  enabled = {
    function()
       -- disable completion in comments
       local context = require "cmp.config.context"
       -- keep command mode completion enabled when cursor is in a comment
       if vim.api.nvim_get_mode().mode == 'c' then
           return true
       else
           return not context.in_treesitter_capture "comment" and not context.in_syntax_group "Comment"
       end
    end
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- import `luasnip` engine
    end,
  },
  mapping = {
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
  formatting = {
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require "lspkind".presets.default[vim_item.kind] ..
                          " " .. vim_item.kind
      -- set a name for each source
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        buffer = "[Buffer]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        cmp_tabnine = "[TabNine]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end
  },
  sources = {
    {name = 'nvim_lsp'}, {name = 'buffer'}, {name = "luasnip"},
    {name = "nvim_lua"}, {name = "path"}, {name = 'cmp_tabnine'}
  },
  completion = {completeopt = 'menu,menuone,noselect,noinsert'},
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
  experimental = {
    ghost_text = false,
    native_menu = false,
  },
}

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp-git' },
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})

cmp.setup.filetype("TelescopePrompt", {
    enabled = false,
})

-- TabNine
local tabnine = require "cmp_tabnine.config"
tabnine:setup({max_lines = 1000, max_num_results = 20, sort = true})

-- Database completion
vim.api.nvim_exec([[
autocmd FileType sql,mysql,plsql lua require "cmp".setup.buffer({ sources = {{ name = "vim-dadbod-completion" }} })
]], false)