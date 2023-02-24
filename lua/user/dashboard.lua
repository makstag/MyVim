local db = require "dashboard"
db.setup({
  theme = 'hyper',
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
    week_header = {
      enable = false,
    },
    shortcut = {
      { desc = 'Update', group = '@property', action = 'Lazy update', key = 'SPC u' },
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
  },
})
vim.keymap.set("n", "<Leader>o", ":DashboardNewFile<CR>", { silent = true })