require("dap-vscode-js").setup({
  debugger_path = os.getenv("HOME") .. "/src/dotfiles/dependencies/vscode-js-debug", -- Path to vscode-js-debug installation.
  adapters = { 'pwa-node' } -- { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

local dap = require('dap');
dap.set_log_level('TRACE')
for _, language in ipairs({ "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require 'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    }
  }
end

-- vim.fn.sign_define('DapBreakpoint',
--                    {text = '🟥', texthl = '', linehl = '', numhl = ''})
-- vim.fn.sign_define('DapBreakpointRejected',
--                    {text = '🟦', texthl = '', linehl = '', numhl = ''})
-- vim.fn.sign_define('DapStopped',
--                    {text = '⭐️', texthl = '', linehl = '', numhl = ''})

vim.keymap.set('n', '<F9>',
  function() require "dap".toggle_breakpoint() end)
vim.keymap.set('n', '<F5>', function() require "dap".continue() end)
vim.keymap.set('n', '<F2>',
  ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')

