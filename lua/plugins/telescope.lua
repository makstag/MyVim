return 
{
	"nvim-telescope/telescope.nvim",
	dependencies = "nvim-lua/plenary.nvim",
	config = function()
		require("telescope").setup()
		local nm = require("utils.alias").nm
		
		nm("<space>ff", "<cmd>Telescope find_files<cr>")
		nm("<space>fg", "<cmd>Telescope live_grep<cr>")
		nm("<space>fb", "<cmd>Telescope buffers<cr>")
		nm("<space>fs", "<cmd>Telescope git_status<cr>")
		nm("<space>fc", "<cmd>Telescope git commits<cr>")
	end
}