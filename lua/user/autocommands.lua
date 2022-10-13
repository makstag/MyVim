--[[ --auto compile
vim.api.nvim_create_autocmd("BufWritePre", {
	command = "lua vim.lsp.buf.formatting_sync(nil, 1000)",
	pattern = "*.astro,*.cpp,*.css,*.go,*.h,*.html,*.js,*.json,*.jsx,*.lua,*.md,*.py,*.rs,*.ts,*.tsx,*.yaml",
})
]]
vim.api.nvim_create_autocmd("InsertEnter", { command = "set norelativenumber", pattern = "*" })
vim.api.nvim_create_autocmd("InsertLeave", { command = "set relativenumber", pattern = "*" })
vim.api.nvim_create_autocmd("TermOpen", { command = "startinsert", pattern = "*" })
vim.api.nvim_create_autocmd("BufWinEnter", { command = "set noexpandtab tabstop=2 shiftwidth=2", pattern = "*.rs" })

vim.cmd "sign define DiagnosticSignError text=● texthl=DiagnosticSignError"
vim.cmd "sign define DiagnosticSignWarn text=● texthl=DiagnosticSignWarn"
vim.cmd "sign define DiagnosticSignInfo text=● texthl=DiagnosticSignInfo"
vim.cmd "sign define DiagnosticSignHint text=● texthl=DiagnosticSignHint"

vim.diagnostic.config { virtual_text = false }