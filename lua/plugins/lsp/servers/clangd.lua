local handler = require "config.lsp.handlers"
local clangd_ext_handler = require "lsp-status".extensions.clangd.setup {}

return 
{
	cmd = 
	{
		"clangd",
		"--background-index",
	     "-j=12",
	     "--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
	     "--clang-tidy",
	     "--clang-tidy-checks=*",
	     "--all-scopes-completion",
	     "--cross-file-rename",
	     "--completion-style=detailed",
	     "--header-insertion-decorators",
	     "--header-insertion=iwyu",
	     "--pch-storage=memory"
	},
	handlers = handler.with { clangd_ext_handler },
	filetypes = { "c", "cpp", "cuda", "proto", "cc" },
	init_options = 
	{
		clangdFileStatus = true,
		usePlaceholders = true,
		completeUnimported = true,
		semanticHighlightings = true
	}
}