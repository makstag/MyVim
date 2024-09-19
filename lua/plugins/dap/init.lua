return
{
	"mfussenegger/nvim-dap",
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"rcarriga/nvim-dap-ui",
		"nvim-telescope/telescope-dap.nvim",
		"rcarriga/cmp-dap",
		"nvim-neotest/nvim-nio"
	},
	config = function()
		require("plugins.dap.debug").setup({})
	end
}