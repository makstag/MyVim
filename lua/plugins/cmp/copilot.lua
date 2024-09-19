require("copilot").setup(
{
	suggestion = {
	auto_trigger = true,
		keymap = {
			accept = "<M-l>",
			accept_word = false,
			accept_line = false,
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>"
		}
	},
	filetypes = {
		c = true,
		cpp = true,
		asm = true
	}
})

vim.api.nvim_command("highlight link CopilotAnnotation LineNr")
vim.api.nvim_command("highlight link CopilotSuggestion LineNr")

local im = require "utils.alias".im

im("<C-S-e>", function() --[copilot] accept suggestion
	require("cmp").mapping.abort()
	require("copilot.suggestion").accept()
end)
