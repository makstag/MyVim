require'ts_context_commentstring'.setup {}
local configs = require'nvim-treesitter.configs'
configs.setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "cmake",
    "comment",
    "cuda",
    "dockerfile",
    "doxygen",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "json",
    "llvm",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "ninja",
    "proto",
    "todotxt",
    "python"
  }, -- Only use parsers that are maintained
  highlight = { -- enable highlighting
    enable = true, 
    disable = { "" },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false, -- default is disabled anyways
  },
  -- see https://github.com/p00f/nvim-ts-rainbow#installation-and-setup
  rainbow = {
    enable = false,
    disable = { "cpp" }, -- list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },

  -- see https://github.com/nvim-treesitter/playground#setup
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    config = {
      c = { __default = '/* %s */', __multiline = '/* %s */' },
      cpp = { __default = '// %s', __multiline = '/* %s */' },
      python = { __default = '# %s', __multiline = '""" %s """' },
    }
  },
  autotag = {
    enable = true,
    -- filetypes = { "html" , "xml" },
  }
}

-- 开启 Folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99
--[[ nkeymap("<Leader><Leader>l", ":TSBufToggle highlight<CR>") ]]
