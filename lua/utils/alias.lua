-- alias for quick access to the hotkey setting method
local M = {}
local map = vim.api.nvim_set_keymap 

M.nm = function(key, command) 
	map('n', key, command, {noremap = true})
end

M.im = function(key, command)
	map('i', key, command, {noremap = true})
end

M.vm = function(key, command)
	map('v', key, command, {noremap = true})
end

M.tm = function(key, command)
	map('t', key, command, {noremap = true})
end

return M
