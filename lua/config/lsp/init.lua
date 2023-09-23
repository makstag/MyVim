require "config.lsp.handlers".setup {}
require "config.lsp.null-ls"
require "config.lsp.lsp_auto"
require "config.lsp.lspsaga"
require "lsp_lines".setup {}
vim.keymap.set("n", "<Leader>x", require("lsp_lines").toggle)

-- fix: warning: multiple different client offset_encodings detected for buffer, this is not supported yet
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428#issue-1078814897
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end