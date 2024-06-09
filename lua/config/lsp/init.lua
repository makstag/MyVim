local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then	return end

-- lsp
require "config.lsp.mason"

-- lsp-config
require "config.lsp.handlers".setup {}
require "config.lsp.settings"
require "lspsaga".setup { symbol_in_winbar = { enable = false } }
require "lsp_lines".setup {}
