local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = "all", -- Only use parsers that are maintained
  highlight = { -- enable highlighting
    enable = true, 
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false, -- default is disabled anyways
  }
}

