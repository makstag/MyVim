local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = "all", -- Only use parsers that are maintained
  highlight = { -- enable highlighting
    enable = true, 
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false, -- default is disabled anyways
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      c = { __default = '/* %s */', __multiline = '/* %s */' },
      cpp = { __default = '// %s', __multiline = '/* %s */' },
    }
  },
}

