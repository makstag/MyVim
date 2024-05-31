require "dashboard".setup
{
    theme = "hyper",
    disable_move = true,  -- boolean default is false disable move key
    shortcut_type = "letter",
    change_to_vcs_root = false,
    preview = 
    {
        command = "chafa --stretch -C on -c 240 -p on --polite on --color-space rgb -w 9 --dither bayer --dither-grain 2 --dither-intensity 1.0 --threads 2", 
        -- preview command -C on -p on --polite on --threads 2  --stretch
        file_path = vim.fn.stdpath "config" .. "/static/nge.gif",     -- preview file path
        file_height = 36,  -- preview file height
        file_width = 120,    -- preview file width
    },
    config = 
    {
        shortcut = 
        {
            { desc = "Recently latest session", group = "@property", action = "SessionLoad", key = "SPC u" },
            { desc = "Browse Files", group = "DiagnosticHint", action = "Telescope file_browser", key = "SPC n" },
            { desc = "Find File", group = "Label", action = "Telescope find_files", key = "SPC f" },
            { desc = "Configure Neovim", group = "Number", action = "edit ~/.config/nvim/init.lua", key = "SPC v" },
        },
        hide = { tabline = false },
        packages = { enable = true }, -- show how many plugins neovim loaded
        -- limit how many projects list, action when you press key or enter it will run this action.
        -- action can be a functino type, e.g.
        -- action = func(path) vim.cmd("Telescope find_files cwd=" .. path) end
        footer = { "NEOVIM/v0.10.0 CHAFA/v1.12.0" }
    }
}