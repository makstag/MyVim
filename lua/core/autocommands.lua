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
api.nvim_create_autocmd("QuickFixCmdPost", 
{
	callback = function()
		vim.cmd([[Trouble qflist open]])
	end
})
api.nvim_create_autocmd("BufWritePre", 
{
	group = vim.api.nvim_create_augroup("better_backup", { clear = true }),
	callback = function(event)
		local file = vim.uv.fs_realpath(event.match) or event.match
		local backup = vim.fn.fnamemodify(file, ":p:~:h")
		backup = backup:gsub("[/\\]", "%%")
		vim.go.backupext = backup
	end
})