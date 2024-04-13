local api = vim.api

api.nvim_create_autocmd("InsertEnter", { command = "set norelativenumber", pattern = "*" })
api.nvim_create_autocmd("TermOpen", { command = "startinsert", pattern = "*" })
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
api.nvim_create_autocmd(
  {"TextChangedI", "TextChangedP"},
  {
    callback = function()
      local line = vim.api.nvim_get_current_line()
      local cursor = vim.api.nvim_win_get_cursor(0)[2]

      local current = string.sub(line, cursor, cursor + 1)
      if after_line == "" or current == "#" then
          require "cmp".complete()
      end
  end,
  pattern = "*"
})

vim.diagnostic.config { virtual_text = false }