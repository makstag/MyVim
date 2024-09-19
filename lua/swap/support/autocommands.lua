local api = vim.api

api.nvim_create_autocmd("TermOpen", { command = "startinsert", pattern = "*" })
api.nvim_create_autocmd("TermOpen", 
{
    callback = function()
        -- disable line numbers
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        -- always start in insert mode
        vim.cmd("stopinsert")
    end,
    pattern = "*"
})
api.nvim_create_autocmd({"TextChangedI", "TextChangedP"},
{
    callback = function()
        local line = api.nvim_get_current_line()
        local cursor = api.nvim_win_get_cursor(0)[2]

        local current = string.sub(line, cursor, cursor + 1)
        if after_line == "" or current == "#" then require "cmp".complete() end
    end,
    pattern = "*"
})

-- backups
--api.nvim_create_autocmd("BufWritePre", 
--{
--    group = api.nvim_create_augroup("better_backup", { clear = true }),
--    callback = function(event)
--        local file = vim.uv.fs_realpath(event.match) or event.match
--        local backup = vim.fn.fnamemodify(file, ":p:~:h")
--        backup = backup:gsub("[/\\]", "%%")
--        vim.go.backupext = backup
--    end
--})

--api.nvim_create_autocmd("QuickFixCmdPost", { callback = function() vim.cmd([[Trouble qflist open]]) end })

vim.diagnostic.config { virtual_text = false, severity_sort = true }