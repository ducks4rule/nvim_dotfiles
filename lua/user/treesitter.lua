local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end
configs.setup {
  ensure_installed = {
          "bash",
          "bibtex",
          -- "latex",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "regex",
          "vim",
    },
  sync_install = false, 
  ignore_install = {
        "latex",
    }, -- List of parsers to ignore installing
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  indent = { 
    enable = true,
    disable = { "yaml" } },
}

-- Register the LaTeX parser manually
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.latex = {
  install_info = {
    -- Leave dummy data here – we won't build it
    url = "https://github.com/latex-lsp/tree-sitter-latex",
    files = { "src/parser.c", "src/scanner.c" },
  },
  filetype = "tex",
}
