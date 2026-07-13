return {
  -- My plugins here
  -- "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  "numToStr/Comment.nvim", -- easy comment stuff

  -- Colourschemes
  "lunarvim/colorschemes",

  -- Latex
  {'lervag/vimtex',
  config = function ()
        vim.g.vimtex_view_method = 'zathura'
        vim.g.tex_comment_nospell = 1
        vim.g.tex_flavour = 'latex'
      end
  },


  -- cmp plugins
  "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "f3fora/cmp-spell",
  "quangnguyen30192/cmp-nvim-tags", -- for tags - Supercollider

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  },


  -- snippets
  {
  "L3MON4D3/LuaSnip", --snippet engine
        build = "make install_jsregexp",
    },

  -- LSP 
  "williamboman/mason.nvim", -- simple to use language server installer
  "williamboman/mason-lspconfig.nvim", -- simple to use language server installer
  'nvimtools/none-ls.nvim', -- LSP diagnostics and code actions, successor of null-ls
  "neovim/nvim-lspconfig", -- enable LSP 
  {"smjonas/inc-rename.nvim", -- for easy renaming
      config = function()
        require("inc_rename").setup()
      end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  'JoosepAlviste/nvim-ts-context-commentstring',

  -- Telescope
  'nvim-telescope/telescope.nvim',

  -- Git
  "lewis6991/gitsigns.nvim",
  'nvim-tree/nvim-web-devicons', -- fancy icons
  "sindrets/diffview.nvim",

  -- Toggleterm
  "akinsho/toggleterm.nvim",

  -- Jupyter Notebooks
  -- { "kiyoon/jupynium.nvim" }, --, run = "pipx install  ." }
  -- { "rcarriga/nvim-notify" },
  -- { "stevearc/dressing.nvim" },

  -- Debugging
  "mfussenegger/nvim-dap",
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/nvim-nio",
  "rcarriga/nvim-dap-ui",
  "nvim-neotest/neotest",
  "nvim-neotest/neotest-python",
  "folke/neodev.nvim",

    -- Todo list
    {
        "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
    },

  -- Markdown
  {
    "gaoDean/autolist.nvim",
    ft = { "markdown", "text" },
    config = function()
      require("autolist").setup()
    end,
  },

  -- Markdown preview
  {
    "selimacerbas/markdown-preview.nvim",
    dependencies = { "selimacerbas/live-server.nvim" },
    config = function()
      require("markdown_preview").setup({
        default_theme = "dark",
        browser = "wslview",
        instance_mode = "multi",
      })
    end,
  },

}
