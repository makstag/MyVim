return {
	"nvimdev/dashboard-nvim",
	commit = "000448d837f6e7a47f8f342f29526c4d7e49e9ce",
	event = "VimEnter",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("dashboard").setup({
			theme = "hyper",
			disable_move = true,  -- boolean default is false disable move key
			shortcut_type = "number",
			hide = { 
				statusline = false,
				tabline = false,
				winbar = false
			},
			preview = {
				command = "chafa --stretch -C on -c full -p on --polite on --color-space rgb -w 9 --dither bayer --dither-grain 2 --dither-intensity 2.0 --threads 3", 
				-- preview command -C on -p on --polite on --threads 2  --stretch --dither-intensity 1.0 -c full
				file_path = vim.fn.stdpath "config" .. "/dashboard/no8.gif",     -- preview file path
				file_height = 20,  -- preview file height 33
				file_width = 98,    -- preview file width 124
			},
			config = {
				shortcut = {
					{ desc = "Shortcut", group = "DiagnosticHint", action = "Telescope keymaps", key = "n" },
					{ desc = "Find File", group = "Label", action = "Telescope find_files", key = "f" },
					{ desc = "Configure Neovim", group = "Number", action = "edit ~/.config/nvim/init.lua", key = "v" }
				},
				packages = { enable = false }, -- show how many plugins neovim loaded
				-- limit how many projects list, action when you press key or enter it will run this action.
				-- action can be a functino type, e.g.
				-- action = func(path) vim.cmd("Telescope find_files cwd=" .. path) end
				footer = function()
				    return {
				    	"",
					"type  :help<Enter>  or  <F1>  for on-line help",
					"Startup time: " .. require("lazy").stats().startuptime .. " ms"
				    }
				end
			}
		})
	end
}

