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