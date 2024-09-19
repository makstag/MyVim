return 
{
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup()
		local nm = require("utils.alias").nm
		
		nm("<leader>ff", "<cmd>Telescope find_files<cr>")
		nm("<leader>fg", "<cmd>Telescope live_grep<cr>")
		nm("<leader>fb", "<cmd>Telescope buffers<cr>")
		nm("<leader>fs", "<cmd>Telescope git_status<cr>")
		nm("<leader>fc", "<cmd>Telescope git commits<cr>")
	end
}