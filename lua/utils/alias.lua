-- alias for quick access to the hotkey setting method
local M = {}
local map = vim.keymap.set 

M.nm = function(key, command, description) 
	map("n", key, command, { noremap = true, silent = true, desc = description })
end

M.im = function(key, command, description)
	map("i", key, command, { noremap = true, silent = true, desc = description })
end

M.vm = function(key, command, description)
	map("v", key, command, { noremap = true, silent = true, desc = description })
end

M.tm = function(key, command, description)
	map("t", key, command, { noremap = true, silent = true, desc = description })
end

M.xm = function(key, command, description)
	map("x", key, command, { noremap = true, silent = true, desc = description })
end

return M
