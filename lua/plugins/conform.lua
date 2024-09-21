return 
{
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "ConformInfo" },
	config = function()
		local conform = require("conform")
		conform.setup({
			default_format_opts = { lsp_format = "fallback"	},
			formatters_by_ft = {
				c = { "clang-format" },
				cmake = { "cmake-format" },
				cpp = { "clang-format" }
			},
			formatters = {
				["clang-format"] = {
					command = "clang-format",
					prepend_args = { "--style=file", "-i" },
				},
				["cmake-format"] = {
					command = "cmake-format",
					prepend_args = { "-i" },
				}
			}
		})
		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
			    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
			    range = {
				    start = { args.line1, 0 },
				    ["end"] = { args.line2, end_line:len() }
			    }
			end
			
			conform.format({ async = true, lsp_fallback = true, range = range })
		end, { range = true })
	end,
	keys = {
		{
			"<space>rf",
			function()
				require("conform").format({ async = true })
			end,
			desc = "format buffer",
		},
	},
}