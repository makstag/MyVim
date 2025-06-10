return
{
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"williamboman/mason.nvim",
		{
			"jay-babu/mason-null-ls.nvim",
			dependencies = "nvimtools/none-ls.nvim"
		},
		"nvim-lua/lsp-status.nvim",
		"nvimdev/lspsaga.nvim",
		"ray-x/lsp_signature.nvim"
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("mason").setup()
		require("lspsaga").setup({ symbol_in_winbar = { enable = false } })
		
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd

		local term = require("lspsaga.floaterm")

		-- Auto close terminal
		local auto_close_terminal = augroup("AutoCloseTerminal", { clear = true })
		autocmd({ "TermClose" }, {
			group = auto_close_terminal,
			pattern = { "*" },
			callback = function()
				local current_bufnr = vim.fn.expand("<abuf>")
				if term.term_bufnr == tonumber(current_bufnr) then
					term.first_open = nil
					vim.api.nvim_buf_delete(term.term_bufnr, { force = true })
					term.term_bufnr, term.term_winid = nil, nil
					vim.api.nvim_buf_delete(term.shadow_bufnr, { force = true })
					term.shadow_bufnr, term.shadow_winid = nil, nil
				else
					return vim.fn.execute("bdelete! " .. current_bufnr)
				end
			end,
		})
		
		local handler = require("plugins.lsp.handler")
		handler.setup()
		
		local on_attach = handler.on_attach
		local capabilities = handler.capabilitie
		
		local servers = {
			clangd = require("plugins.lsp.servers.clangd")(on_attach), 
			cmake = require("plugins.lsp.servers.cmake")(on_attach), 
			asm_lsp = require("plugins.lsp.servers.asm_lsp")(on_attach),
			autotools_ls = require("plugins.lsp.servers.autotools_ls")(on_attach)
		}
		
		local default_lsp_config = {
			on_attach = on_attach,
			capabilities = capabilities,
			flags = { debounce_text_changes = 200, allow_incremental_sync = true }
		}
		
		local server_names = {}
		local server_configs = {}
		for server_name, server_config in pairs(servers) do
			table.insert(server_names, server_name)
			server_configs[server_name] = server_config
		end
		
		local lspconfig = require("lspconfig")
		local mason = require("mason-lspconfig")
		mason.setup({ 
			ensure_installed = server_names, 
			automatic_installation = true
			--automatic_enable = false 
		})
		--[[mason.setup_handlers({ function(server)
			local merged_config = vim.tbl_deep_extend("force", default_lsp_config, server_configs[server] or {})
			lspconfig[server].setup(merged_config)
		end })]]
		for server, _ in pairs(servers) do
			local merged_config = vim.tbl_deep_extend("force", default_lsp_config, server_configs[server] or {})
			lspconfig[server].setup(merged_config)
		end
		
		-- install formatter
		require("mason-null-ls").setup({
			ensure_installed = { "clang-format", "cmakelang" },
			automatic_installation = true
		})
	end
}
