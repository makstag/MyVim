local prettier = require "prettier"

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
  filetypes = {
    "lua",
    "docker",
    "json",
    "c",
    "markdown",
    "cpp",
    "python",
    "cmake",
    "bash",
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})
