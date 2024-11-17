return
{
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("dashboard").setup({
			theme = "hyper",
			disable_move = true,  -- boolean default is false disable move key
			shortcut_type = "number",
			change_to_vcs_root = false,
			--[[preview = {
				command = "chafa --stretch -C on -c 256 -p on --polite on --color-space rgb -w 9 --dither bayer --dither-grain 2 --dither-intensity 2.0 --threads 3", 
				-- preview command -C on -p on --polite on --threads 2  --stretch --dither-intensity 1.0 -c full
				file_path = vim.fn.stdpath "config" .. "/dashboard/no8.gif",     -- preview file path
				file_height = 36,  -- preview file height 33
				file_width = 130,    -- preview file width 124
			},]]
			config = {
				header = {
					" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
					" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
					" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
					" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
					" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
					" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
					"",
					"",
					""
				},
				shortcut = {
					-- { desc = "Update", group = "@property", action = "Lazy update", key = "u" },
					{ desc = "Shortcut", group = "DiagnosticHint", action = "Telescope keymaps", key = "n" },
					{ desc = "Find File", group = "Label", action = "Telescope find_files", key = "f" },
					{ desc = "Configure Neovim", group = "Number", action = "edit ~/.config/nvim/init.lua", key = "v" }
				},
				hide = { 
					statusline = false,
					tabline = false,
					winbar = false
				},
				packages = { enable = false }, -- show how many plugins neovim loaded
				-- limit how many projects list, action when you press key or enter it will run this action.
				-- action can be a functino type, e.g.
				-- action = func(path) vim.cmd("Telescope find_files cwd=" .. path) end
				footer = { "🚀🚀🚀" }
			}
		})
	end
}
