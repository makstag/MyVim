local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "cmake",
    "comment",
    "css",
    "dockerfile",
    "json",
    "llvm",
    "lua",
    "make",
    "markdown",
    "python",
    "scheme",
    "vim",
    "yaml"
  }, -- Only use parsers that are maintained
  highlight = { -- enable highlighting
    enable = false, 
  },
  indent = {
    enable = false, -- default is disabled anyways
  }
}

