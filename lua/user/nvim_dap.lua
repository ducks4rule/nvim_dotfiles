local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
require('dap-python').setup(mason_path .. "packages/debugpy/venv/bin/python")

-- require("neotest").setup({
--   adapters = {
--     require("neotest-python")({
--       dap = {
--         justMyCode = false,
--         console = "integratedTerminal",
--       },
--       args = { "--log-level", "DEBUG", "--quiet" },
--       runner = "pytest",
--     })
--   }
-- })





-- for the ui
local dapui = require("dapui")
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
vim.keymap.set('n', 'U', require 'dapui'.toggle)

-- dap.listeners.before.event_terminated["dapui_config"]=function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"]=function()
--   dapui.close()
-- end

-- enable type checking for dapui
require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
  ...
})

-- change test runner
-- require('dap-python').test_runner = 'pytest'



-- make messages look better
vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})


-- some keymaps
vim.keymap.set('n', '<F5>', ":wa<CR> :lua require('dap').continue()<CR>")
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)

vim.keymap.set('n', '<leader>u', require 'dapui'.eval)





-- dap.adapters.python = function(cb, config)
--   if config.request == 'attach' then
--     ---@diagnostic disable-next-line: undefined-field
--     local port = (config.connect or config).port
--     ---@diagnostic disable-next-line: undefined-field
--     local host = (config.connect or config).host or '127.0.0.1'
--     cb({
--       type = 'server',
--       port = assert(port, '`connect.port` is required for a python `attach` configuration'),
--       host = host,
--       options = {
--         source_filetype = 'python',
--       },
--     })
--   else
--     cb({
--       type = 'executable',
--       command = '/home/lorenz/.virtualenvs/debugpy/bin/python',
--       args = { '-m', 'debugpy.adapter' },
--       options = {
--         source_filetype = 'python',
--       },
--     })
--   end
-- end
--
--
-- dap.configurations.python = {
--   {
--     -- The first three options are required by nvim-dap
--     type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
--     request = 'launch'; -- or 'attach'
--     name = "Launch file";
--
--     -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
--
--     program = "${file}"; -- This configuration will launch the current file if used.
--     -- console = "internalConsole";
--     console = "integratedTerminal";
--     pythonPath = function()
--       -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
--       -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
--       -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
--       local cwd = vim.fn.getcwd()
--       if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
--         return cwd .. '/venv/bin/python'
--       elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
--         return cwd .. '/.venv/bin/python'
--       else
--         return '/usr/bin/python'
--       end
--     end;
--   },
-- }
