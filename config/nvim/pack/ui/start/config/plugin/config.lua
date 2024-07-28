require('gitsigns').setup({
  numhl = true,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '<leader>hs', gs.stage_buffer)
    map('n', '<leader>hd', gs.toggle_deleted)
  end
})

require'nvim-web-devicons'.setup({})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fF', builtin.git_status, { desc = 'Git Status' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = 'Git Commits' })
vim.keymap.set('n', '<leader>fC', builtin.git_bcommits, { desc = 'Git BCommits' })
vim.keymap.set('n', '<leader>fu', builtin.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>fh', builtin.command_history, {  desc = 'Command History' })

require'colorizer'.setup()

require("which-key").setup({
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
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  show_help = true, -- show help message on the command line when the popup is visible
})

require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    icons_enabled = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'filename' },
    lualine_c = { 'diff' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'diagnostics' },
    lualine_z = { '' },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = { '' },
    lualine_c = { '' },
    lualine_x = { '' },
    lualine_y = { '' },
    lualine_z = { '' },
  },
})

require("chatgpt").setup({
      predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/kieran-ohara/dotfiles/main/prompts/prompts.csv",
})
vim.keymap.set('n', '<leader>cc', '<cmd>ChatGPT<CR>', {  desc = 'Chat' })
vim.keymap.set('n', '<leader>ce', '<cmd>ChatGPTEditWithInstructions<CR>', {  desc = 'Edit' })
