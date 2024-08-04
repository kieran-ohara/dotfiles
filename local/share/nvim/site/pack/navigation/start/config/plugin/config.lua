local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fa', builtin.find_files, { desc = 'Find all files' })
vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = 'Find git files' })
vim.keymap.set('n', '<leader>fF', builtin.git_status, { desc = 'Git Status' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = 'Git Commits' })
vim.keymap.set('n', '<leader>fC', builtin.git_bcommits, { desc = 'Git BCommits' })
vim.keymap.set('n', '<leader>fu', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', builtin.command_history, {  desc = 'Command History' })

local wk = require('which-key')
wk.setup({
  preset = "helix",
  plugins = {
    marks = false, -- shows a list of your marks on ' and `
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = false, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
 },
  show_help = true, -- show help message on the command line when the popup is visible
})
wk.add({
  { "<leader>c", group = "ChatGPT" },
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "Git" },
  { "<leader>l", group = "LSP" },
  { "<leader>t", group = "Treesitter" },
})

require("oil").setup({
  use_default_keymaps = false,
  keymaps = {
    ["i"] = "actions.select",
  },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
