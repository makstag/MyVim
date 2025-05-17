-- ██╗      █████╗ ███████╗██╗   ██╗         Z
-- ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝      Z
-- ██║     ███████║  ███╔╝  ╚████╔╝    z
-- ██║     ██╔══██║ ███╔╝    ╚██╔╝   z
-- ███████╗██║  ██║███████╗   ██║
-- ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
 	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  	if vim.v.shell_error ~= 0 then
   		vim.api.nvim_echo({
      		{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      		{ out, "WarningMsg" },
      		{ "\nPress any key to exit..." },
    		}, true, {})
    		vim.fn.getchar()
    		os.exit(1)
  	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	colorscheme = "cyberdream",
	spec = { { import = "plugins" } },
	ui = {
		size = { width = 0.8, height = 0.8 },
		wrap = true,
		border = "shadow",
		icons = require("utils.icons").lazy,
	},
	pkg = {
		enabled = true,
		cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
		versions = true, -- Honor versions in pkg sources
		-- the first package source that is found for a plugin will be used.
		sources = {
			"lazy",
			"rockspec",
			"packspec"
		}
	},
	rocks = {
		enabled = true,
		hererocks = true,
		root = vim.fn.stdpath("data") .. "/lazy-rocks",
		server = "https://nvim-neorocks.github.io/rocks-binaries/"
	},
	checker = { 
		enabled = true,
		notify = false 
	}
})
