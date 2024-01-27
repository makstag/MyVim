require "core.options"
require "core.keymaps"

local path = string.format("%s/core/plugins.vim", vim.fn.stdpath "config")
local scmd = "source " .. path
vim.cmd(scmd)