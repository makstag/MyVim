return
{
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
		"nvim-telescope/telescope-dap.nvim",
		"rcarriga/cmp-dap",
		"nvim-neotest/nvim-nio"
	},
	config = function()
		require("plugins.dap.debugger").setup()
		require("cmp").setup.filetype({ "TelescopePrompt", "dap-repl", "dapui_watches", "dapui_hover" }, {
			enabled = true,
			sources = { { name = "dap" } }
		})
	end
}