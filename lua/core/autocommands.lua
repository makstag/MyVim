local autocmd = vim.api.nvim_create_autocmd

autocmd("TermOpen", { command = "startinsert", pattern = "*" })
autocmd("TermOpen", 
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
autocmd("QuickFixCmdPost", 
{
	callback = function()
		vim.cmd([[Trouble qflist open]])
	end
})

vim.g.autoformat = true
local augroup = vim.api.nvim_create_augroup

augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	callback = function()
		vim.cmd("FormatWrite")
	end,
	pattern = "*"
})

augroup("__update__", { clear = true })
autocmd("VimEnter", {
	group = "__update__",
	callback = function()
		require("lazy").update({ show = false })
	end
})