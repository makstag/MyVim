return
{
    "neovim/nvim-lspconfig",
    dependencies = {
	    "williamboman/mason-lspconfig.nvim",
	    "williamboman/mason.nvim",
	    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	    "ray-x/lsp_signature.nvim"
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
    end
}










local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then	return end

-- lsp
require "config.lsp.mason"

-- lsp-config
require "config.lsp.handlers".setup {}
require "config.lsp.settings"
require "lspsaga".setup { symbol_in_winbar = { enable = false } }
require "lsp_lines".setup {}
