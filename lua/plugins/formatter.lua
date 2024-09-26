return
{
	"mhartington/formatter.nvim",
	cmd = { "FormatWrite", "Format" }, -- Utilities for creating configurations
	config = function()
		require("formatter").setup({
			-- Enable or disable logging
			logging = false,
			-- Set the log level
			log_level = vim.log.levels.DEBUG,
			-- All formatter configurations are opt-in
			filetype = {
				cpp = {
					-- clang-format
					function()
						return {
							exe = "clang-format",
							args = {
								"-style='{ BasedOnStyle: WebKit, IndentWidth: 4, SortIncludes: false }'",
								"--assume-filename",
								"-i",
								vim.api.nvim_buf_get_name(0)
							},
							stdin = true,
							cwd = vim.fn.expand("%:p:h") -- Run clang-format in cwd of the file.
						}
					end
				},
				c = {
					-- clang-format
					function()
						return {
							exe = "clang-format",
							args = {
								"-style='{ BasedOnStyle: WebKit, IndentWidth: 4, SortIncludes: false }'",
								"--assume-filename",
								"-i",
								vim.api.nvim_buf_get_name(0)
							},
							stdin = true,
							cwd = vim.fn.expand("%:p:h") -- Run clang-format in cwd of the file.
						}
					end
				},
				-- Use the special "*" filetype for defining formatter configurations on any filetype
				["*"] = {
					-- "formatter.filetypes.any" defines default configurations for any filetype
					require("formatter.filetypes.any").remove_trailing_whitespace
					-- Remove trailing whitespace without "sed"
					-- require("formatter.filetypes.any").substitute_trailing_whitespace
				}
			}
		})
	end
}