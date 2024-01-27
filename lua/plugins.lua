local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system 
    {
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
vim.cmd 
[[
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
packer.init 
{
    -- snapshot = "july-24",
    snapshot_path = fn.stdpath "config" .. "/snapshots",
    max_jobs = 50,
    display = 
    {
        open_fn = function()
            return require "packer.util".float { border = "rounded" }
        end,
        prompt_border = "rounded", -- Border style of prompt popups.
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- Plugin Mangager
    use { "lewis6991/impatient.nvim", config = [[require "config.impatient"]] }
    use "wbthomason/packer.nvim" -- Have packer manage itself

    -- Lua Development
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
    use "nvim-lua/popup.nvim"
    use "folke/neodev.nvim"

    -- LSP
    use { "neovim/nvim-lspconfig", config = [[require "config.lsp"]]
    use "nvimdev/lspsaga.nvim"
    use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"

    -- Completion
    use { "onsails/lspkind-nvim", event = "VimEnter" }
    use 
    { 
        "hrsh7th/nvim-cmp", 
        after = "lspkind-nvim",
        config = [[require "config.nvim-cmp"]] 
    }
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use 
    {
        "tzachar/cmp-tabnine",
        run = "./install.sh",
        requires = "hrsh7th/nvim-cmp"
    }
    use 
    {
        "L3MON4D3/LuaSnip",
        requires = "rafamadriz/friendly-snippets",
        tag = "v2.*",
        run = "make install_jsregexp",
        config = function(opts) 
            if opts then require "luasnip".config.setup(opts) end
            vim.tbl_map(
                function(type) require("luasnip.loaders.from_" .. type).lazy_load() end,
                { "vscode", "snipmate", "lua" }
            )
            require "luasnip".filetype_extend("c", { "cdoc" })
            require "luasnip".filetype_extend("cpp", { "cppdoc" })
            require "luasnip".filetype_extend("cc", { "ccdoc" })
        end
    }

    -- Syntax/Treesitter
    use 
    {
        "nvim-treesitter/nvim-treesitter",
        event = "BufEnter",
        run = function() require "nvim-treesitter.install".update({with_sync = true}) end, 
        config = [[require "config.treesitter"]]
    }
    use { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" }
    use
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
        requires = "nvim-treesitter/nvim-treesitter"
    }
    
    -- Color
    use "norcalli/nvim-colorizer.lua"

    -- Colorschemes
    use { "maxmx03/fluoromachine.nvim", config = [[require "config.colorscheme"]] }

    -- Debugging
    use 
    {
        "mfussenegger/nvim-dap",
        requires = 
        {
            { "theHamsta/nvim-dap-virtual-text", module = { "nvim-dap-virtual-text" } },
            { "rcarriga/nvim-dap-ui", module = { "dapui" } },
            -- { "mfussenegger/nvim-dap-python", module = { "dap-python" } },
            "nvim-telescope/telescope-dap.nvim",
            -- { "jbyuki/one-small-step-for-vimkind", module = "osv" },
        },
        config = function()
            require "config.dap".setup {}
        end
    }

    -- Statusline
    use 
    { 
        "nvim-lualine/lualine.nvim", 
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
        config = [[require "config.lualine"]]
    }
    use 
    {
        "akinsho/bufferline.nvim", 
        event = "VimEnter",
        tag = "*", 
        cond = firenvim_not_active,
        requires = "nvim-tree/nvim-web-devicons",
        config = [[require "config.bufferline"]] 
    }
    
    
    
    
  -- File Explorer
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    tag = "nightly",
    config = function() require'nvim-tree'.setup {} end
  }
  use "ThePrimeagen/harpoon"

  -- Preview
  use {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    requires = {"nvim-tree/nvim-web-devicons"}
  }
 
  -- Comment
  use "numToStr/Comment.nvim"
  use "folke/todo-comments.nvim"

  -- Terminal
  use "akinsho/toggleterm.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use {
    "nvim-telescope/telescope-fzf-native.nvim", 
    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  }
  -- use {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   requires = { "kkharji/sqlite.lua" },
  -- }

  -- Project
  use "ahmedkhalf/project.nvim"
  use "nvim-pack/nvim-spectre"
  use "tpope/vim-obsession"

  -- Quickfix
  --use { 'kevinhwang91/nvim-bqf', ft = "qf", config = [[require('config.bqf')]] }
  use 'kevinhwang91/nvim-bqf'

  -- Startup time
  use "dstein64/vim-startuptime"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim"
  use "ruifm/gitlinker.nvim"
  use "mattn/vim-gist"
  use "mattn/webapi-vim"

  -- Github
  use "pwntester/octo.nvim"

  --AI
  --[[
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false }
      })
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }
  ]]

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
    disable = false
  }

  -- Editing Support
  use "windwp/nvim-autopairs"
  use "andymass/vim-matchup"
  use "folke/zen-mode.nvim"

  -- Latex
  use "lervag/vimtex"

  -- Markdown
  use 
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown"
  }

  --use { 'aserowy/tmux.nvim',  config = [[require('config.tmux')]] }
  use 'aserowy/tmux.nvim'
  --use { 'rcarriga/nvim-notify',
  --  event = "BufEnter",
  --  config = function() vim.defer_fn(function() 
  --    require("config.nvim-notify") end, 2000) end,
  --}
  --use { 'karb94/neoscroll.nvim', config = [[require('config.neoscroll')]] }
  use 'karb94/neoscroll.nvim'
    -- Utility
    use "cdelledonne/vim-cmake"

    use 
    {
        "j-hui/fidget.nvim", 
        after = "nvim-lspconfig",
        config = [[require "config.fidget-nvim"]] 
    }
    use { "rmagatti/goto-preview", config = [[require "config.goto-preview"]] }
    use
    {
        "nvimdev/guard.nvim",
        requires = "nvimdev/guard-collection",
        event = "BufReadPre",
        config = [[require "config.guard"]]  
    }
    use { "ganquan/autocwd", config = [[require "config.autocwd"]] }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
