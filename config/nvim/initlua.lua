local cmp = require'cmp'
cmp.setup({
    mapping = {
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'buffer' },
    })
})
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  })
})

require'nvim-treesitter.configs'.setup {
    ensure_installed = {},
    incremental_selection = {
        enable = true;
    },
    indent = {
        enable = true,
    },
    highlight = {
        enable = true,
    },
    playground = {
      enable = false,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                -- ["aa"] = "@parameter.outer", it does not work!
                ["ia"] = "@parameter.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>sl"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>sh"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                -- ["]]"] = "@class.outer",
            },
            goto_next_end = {
                -- ["]M"] = "@function.outer",
                -- ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                -- ["[["] = "@class.outer",
            },
            goto_previous_end = {
                -- ["[M"] = "@function.outer",
                -- ["[]"] = "@class.outer",
            },
        },
    },
}

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
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '<leader>hs', gs.stage_buffer)
    map('n', '<leader>hd', gs.toggle_deleted)
  end
})
