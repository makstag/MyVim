return 
{
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			variant = "auto", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`

    			-- Enable transparent background
    			transparent = true,
    			
    			-- Apply a modern borderless look to pickers like Telescope, Snacks Picker & Fzf-Lua
    			borderless_pickers = true,
		})
		vim.cmd("colorscheme cyberdream")
	end
}
