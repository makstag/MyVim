-- alias for quick access to the hotkey setting method
local M = {}
local map = vim.keymap.set 

local function opts(description)
	return { noremap = true, silent = true, desc = description }
end


M.nm = function(key, command, description) 
	map("n", key, command, opts(description))
end

M.im = function(key, command, description)
	map("i", key, command, opts(description))
end

M.vm = function(key, command, description)
	map("v", key, command, opts(description))
end

M.tm = function(key, command, description)
	map("t", key, command, opts(description))
end

M.xm = function(key, command, description)
	map("x", key, command, opts(description))
end

return M
