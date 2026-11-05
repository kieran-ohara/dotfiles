local gitsigns = require('gitsigns')

gitsigns.setup({
  numhl = true,
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gitsigns.nav_hunk('next') end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gitsigns.nav_hunk('prev') end)
      return '<Ignore>'
    end, { expr = true })

    -- <leader>gd targets this name; the vim tree defines it as :Gdiff for
    -- both editors, and this buffer-local redefinition wins where gitsigns
    -- is attached.
    map('n', '<Plug>(git-diff)', gitsigns.diffthis, { desc = 'Diff against the index' })
  end
})
