local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

-- lsp
require "config.lsp.mason"
require "config.lsp.mason-lspconfig"
-- lsp-config
require "config.lsp.handlers".setup{}
require "config.lsp.settings"
require "config.lsp.lspsaga"

-- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#asm_lsp
require "lspconfig".asm_lsp.setup{} -- use lsp-installer failed
require "lsp_lines".setup{}
