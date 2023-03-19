local api = vim.api

api.nvim_create_autocmd("InsertEnter", { command = "set norelativenumber", pattern = "*" })
api.nvim_create_autocmd("TermOpen", { command = "startinsert", pattern = "*" })
api.nvim_create_autocmd(
  {"TextChangedI", "TextChangedP"},
  {
    callback = function()
      local line = vim.api.nvim_get_current_line()
      local cursor = vim.api.nvim_win_get_cursor(0)[2]

      local current = string.sub(line, cursor, cursor + 1)
      if current == "." or current == "," or current == " " then
        require "cmp".close()
      end

      local before_line = string.sub(line, 1, cursor + 1)
      local after_line = string.sub(line, cursor + 1, -1)
      if not string.match(before_line, "^%s+$") then
        if after_line == "" or string.match(before_line, " $") or string.match(before_line, "%.$") then
          require "cmp".complete()
        end
      end
  end,
  pattern = "*"
})
-- vim.opt.foldmethod     = 'expr'
-- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
---WORKAROUND
--[[vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod     = 'expr'
    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  end
})]]
---ENDWORKAROUND

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        -- disable line numbers
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        -- always start in insert mode
        vim.cmd("stopinsert")
    end,
    pattern = "*"
})

vim.diagnostic.config { virtual_text = false }