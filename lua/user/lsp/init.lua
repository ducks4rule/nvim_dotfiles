require("user.lsp.handlers").setup()
require "user.lsp.mason"
require "user.lsp.null-ls"




local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end





--[[ -- give root directory to pyright ]]
--[[ local util = require("lspconfig/util") ]]
--[[]]
--[[ lspconfig.pyright.setup({ ]]
--[[   root_dir = function(fname) ]]
--[[     return util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or ]]
--[[       util.path.dirname(fname) ]]
--[[   end ]]
--[[ }) ]]
