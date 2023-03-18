local home = vim.fn.stdpath"config"
local db = require"dashboard"

db.setup({
  theme = 'hyper',
  disable_move = true,  -- boolean default is false disable move key
  shortcut_type = 'letter',
  change_to_vcs_root = false,
  preview = {
    command = 'chafa -c full --polite on --stretch --threads 2', -- preview command -C on -p on --polite on
    file_path = home .. '/static/db.gif',     -- preview file path
    file_height = 30,  -- preview file height
    file_width = 120,    -- preview file width
  },
  config = {
    header = {
      '               ▄▄██████████▄▄             ',
      '               ▀▀▀   ██   ▀▀▀             ',
      '       ▄██▄   ▄▄████████████▄▄   ▄██▄     ',
      '     ▄███▀  ▄████▀▀▀    ▀▀▀████▄  ▀███▄   ',
      '    ████▄ ▄███▀              ▀███▄ ▄████  ',
      '   ███▀█████▀▄████▄      ▄████▄▀█████▀███ ',
      '   ██▀  ███▀ ██████      ██████ ▀███  ▀██ ',
      '    ▀  ▄██▀  ▀████▀  ▄▄  ▀████▀  ▀██▄  ▀  ',
      '       ███           ▀▀           ███     ',
      '       ██████████████████████████████     ',
      '   ▄█  ▀██  ███   ██    ██   ███  ██▀  █▄ ',
      '   ███  ███ ███   ██    ██   ███▄███  ███ ',
      '   ▀██▄████████   ██    ██   ████████▄██▀ ',
      '    ▀███▀ ▀████   ██    ██   ████▀ ▀███▀  ',
      '     ▀███▄  ▀███████    ███████▀  ▄███▀   ',
      '       ▀███    ▀▀██████████▀▀▀   ███▀     ',
      '         ▀    ▄▄▄    ██    ▄▄▄    ▀       ',
      '               ▀████████████▀             ',
      '',
      '',
      '',
      '',
    },
    shortcut = {
      { desc = 'Recently latest session', group = '@property', action = 'SessionLoad', key = 'SPC u' },
      {
        desc = 'Browse Files',
        group = 'DiagnosticHint',
        action = 'Telescope file_browser',
        key = 'SPC n',
      },
      {
        desc = 'Find File',
        group = 'Label',
        action = 'Telescope find_files',
        key = 'SPC f',
      },
      {
        desc = 'Configure Neovim',
        group = 'Number',
        action = 'edit ~/.config/nvim/init.lua',
        key = 'SPC v',
      },
    },
    hide = {
  	tabline = false       -- hide the tabline
    },
    packages = { enable = false }, -- show how many plugins neovim loaded
    -- limit how many projects list, action when you press key or enter it will run this action.
    -- action can be a functino type, e.g.
    -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
    footer = {'321neovim'}, -- footer
  },
})

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        -- disable line numbers
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        -- always start in insert mode
        vim.cmd("stopinsert")
    end,
})

vim.keymap.set("n", "<Leader>o", ":DashboardNewFile<CR>", { silent = true })