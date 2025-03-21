return 
{
	"maxmx03/fluoromachine.nvim",
	lazy = false,
	priority = 1000,
	config = function ()
		function overrides(c)
			return 
			{
				TelescopeResultsBorder = { fg = c.alt_bg, bg = c.alt_bg },
				TelescopeResultsNormal = { bg = c.alt_bg },
				TelescopePreviewNormal = { bg = c.bg },
				TelescopePromptBorder = { fg = c.alt_bg, bg = c.alt_bg },
				TelescopeTitle = { fg = c.fg, bg = c.comment },
				TelescopePromptPrefix = { fg = c.purple }
			}
		end
		
		require("fluoromachine").setup({
			glow = false,
			theme = "retrowave",
			overrides = overrides,
			transparent = "full",
			colors = function(_, d)
				return 
				{
					bg = "#190920",
					alt_bg = "#190920",
					cyan = "#49eaff",
					red = "#ff1e34",
					yellow = "#ffe756",
					orange = "#f38e21",
					pink = "#ffadff",
					purple = "#9544f7"
				}
			end
		})
		
		vim.cmd("colorscheme fluoromachine")
	end
}
