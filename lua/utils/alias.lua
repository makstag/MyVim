-- alias for quick access to the hotkey setting method
local M = {}
local map = vim.keymap.set 

M.nm = function(key, command) 
	map("n", key, command, { noremap = true, silent = true })
end

M.im = function(key, command)
	map("i", key, command, { noremap = true, silent = true })
end

M.vm = function(key, command)
	map("v", key, command, { noremap = true, silent = true })
end

M.tm = function(key, command)
	map("t", key, command, { noremap = true, silent = true })
end

M.xm = function(key, command)
	map("x", key, command, { noremap = true, silent = true })
end

return M
