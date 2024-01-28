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
    use { "lewis6991/impatient.nvim", config = [[require "impatient"]] }
    use "wbthomason/packer.nvim" -- Have packer manage itself

    -- Lua Development
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
    use { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" } -- TODO: examine
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
            "nvim-telescope/telescope-dap.nvim",
            "rcarriga/cmp-dap"
        },
        config = function()
            require "config.dap".setup {}
        end
    } -- TODO: examine

    -- GUI
    use 
    { 
        "nvim-lualine/lualine.nvim", 
        after = "fluoromachine",
        requires = "nvim-tree/nvim-web-devicons"
        config = function()
            require "lualine".setup { options = { theme = "retrowave" } }
        end
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
    use 
    {
        "kyazdani42/nvim-tree.lua",
        requires = "kyazdani42/nvim-web-devicons",
        tag = "nightly",
        config = function() require "nvim-tree".setup {} end
    }

    -- Preview
    use 
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        requires = "nvim-tree/nvim-web-devicons",
        config = [[require "config.dashboard"]] 
    }
 
    -- Terminal
    use { "akinsho/toggleterm.nvim", tag = "*", config = [[require "config.toggleterm"]] }

    -- Telescope
    use 
    { 
        "nvim-telescope/telescope.nvim", 
        tag = "*", 
        requires = "nvim-lua/plenary.nvim", 
        config = [[require "config.telescope"]] 
    }
    use { "nvim-telescope/telescope-ui-select.nvim", requires = "nvim-lua/plenary.nvim" } -- TODO: examine
    use 
    {
        "nvim-telescope/telescope-fzf-native.nvim", 
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    }

    -- Project
    use { "nvim-pack/nvim-spectre", [[require "config.specter"]] } -- TODO: examine

    -- Quickfix
    use { "kevinhwang91/nvim-bqf", ft = "qf", config = [[require "config.bqf"]] }

    -- Git
    use { "lewis6991/gitsigns.nvim", config = [[require "config.gitsigns"]] } -- TODO: examine

    -- WhichKey
    use 
    {
        "folke/which-key.nvim",
        event = "VimEnter",
        module = { "which-key" },
        -- keys = { [[<leader>]] },
        -- config = function() require("config.whichkey").setup() end,
        disable = false
    } -- TODO: examine

    -- Editing Support
    use { "windwp/nvim-autopairs", config = [[require "config.autopairs"]] }

    use { "karb94/neoscroll.nvim", config = [[require"config.neoscroll"]] } -- TODO: examine

    -- Utility
    use "cdelledonne/vim-cmake"

    use 
    {
        "j-hui/fidget.nvim", 
        after = "nvim-lspconfig",
        config = [[require "config.fidget-nvim"]] 
    } -- TODO: examine
    
    use { "rmagatti/goto-preview", config = [[require "config.goto-preview"]] } -- TODO: examine
    
    use
    {
        "nvimdev/guard.nvim",
        requires = "nvimdev/guard-collection",
        event = "BufReadPre",
        config = [[require "config.guard"]]  
    }
    
    use { "ganquan/autocwd", config = function() require "autocwd".setup{} end }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
