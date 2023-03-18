local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  -- snapshot = "july-24",
  snapshot_path = fn.stdpath "config" .. "/snapshots",
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded", -- Border style of prompt popups.
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Plugin Mangager
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Lua Development
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "nvim-lua/popup.nvim"
  use "folke/lua-dev.nvim"

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "jose-elias-alvarez/null-ls.nvim"
  use "MunifTanjim/prettier.nvim"
  use 'folke/trouble.nvim'
  use "glepnir/lspsaga.nvim"
  use "onsails/lspkind-nvim"
  use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
  use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim"
  }

  -- Completion
  use "hrsh7th/nvim-cmp"    -- The completion plugin
  use "hrsh7th/cmp-buffer"  -- Buffer completions
  use "hrsh7th/cmp-path"    -- Path completions
  use "hrsh7th/cmp-cmdline" -- Cmdline completions
  use "hrsh7th/cmp-nvim-lsp"
  -- cmp snippet engine
  use {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    tag = "v<CurrentMajor>.*",
    -- install jsregexp (optional!:).
    run = "make install_jsregexp"
  }
  use "hrsh7th/cmp-nvim-lua" -- nvim-cmp source for neovim lua api
  use "rafamadriz/friendly-snippets"
  use {
    'tzachar/cmp-tabnine',
    run = './install.sh',
    requires = 'hrsh7th/nvim-cmp'
  }

  -- Syntax/Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
        local ts_update = require "nvim-treesitter.install".update({ with_sync = true })
        ts_update()
    end,
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Color
  use "norcalli/nvim-colorizer.lua"
  use "nvim-colortils/colortils.nvim"

  -- Colorschemes
  use "folke/tokyonight.nvim"
  use "lunarvim/synthwave84.nvim"

  -- Utility
  use "moll/vim-bbye"
  use "lewis6991/impatient.nvim"
  use "cdelledonne/vim-cmake"
  use "antoinemadec/FixCursorHold.nvim"

  -- Debugging
  use {
      "mfussenegger/nvim-dap",
      opt = true,
      module = { "dap" },
      requires = {
        { "theHamsta/nvim-dap-virtual-text", module = { "nvim-dap-virtual-text" } },
        { "rcarriga/nvim-dap-ui", module = { "dapui" } },
        --{ "mfussenegger/nvim-dap-python", module = { "dap-python" } },
        "nvim-telescope/telescope-dap.nvim",
        --{ "jbyuki/one-small-step-for-vimkind", module = "osv" },
      },
      config = function()
        require("config.dap").setup()
      end,
      disable = false,
  }

  -- Statusline
  use "nvim-lualine/lualine.nvim"

  -- File Explorer
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    tag = "nightly"
  }

  -- Preview
    use {
        "goolord/alpha-nvim",
        requires = { "nvim-tree/nvim-web-devicons" },
        --config = function ()
        --    require"alpha".setup(require"alpha.themes.startify".config)
        --end
    }
    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        requires = {'nvim-tree/nvim-web-devicons'}
    }

  -- Ranger terminal file manager
  use "kevinhwang91/rnvimr"

  -- ASCII image viewer
  use {
    "samodostal/image.nvim",
	config = function()
	  require("image").setup {
	    render = {
	      min_padding = 5,
	      show_label = true,
	      use_dither = true,
	    },
	    events = {
	      update_on_nvim_resize = true,
	    },
	  }
	end,
  }
 
  -- Comment
  use "numToStr/Comment.nvim"
  use "folke/todo-comments.nvim"

  -- Terminal
  use "akinsho/toggleterm.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"

  -- Project
  use "ahmedkhalf/project.nvim"
  use "windwp/nvim-spectre"

  -- Quickfix
  use "kevinhwang91/nvim-bqf"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim"
  use "ruifm/gitlinker.nvim"
  use "mattn/vim-gist"
  use "mattn/webapi-vim"

  -- Github
  use "pwntester/octo.nvim"

  -- surround: Add/change/delete surrouding delimiter pairs
  use {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require "nvim-surround".setup {
        -- Configuration here, or leave empty to use defaults
      }
    end
  }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      module = { "which-key" },
      -- keys = { [[<leader>]] },
      config = function()
        require("config.whichkey").setup()
      end,
      disable = false,
    }

  -- Editing Support
  use "windwp/nvim-autopairs"
  use "andymass/vim-matchup"
  use "folke/zen-mode.nvim"

  -- Latex
  use "lervag/vimtex"

  -- Markdown
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
