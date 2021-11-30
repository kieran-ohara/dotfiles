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
}
require "nvim-treesitter.configs".setup {
  playground = {
    enable = false,
  }
}
require'lspkind'.init{}
require'trouble'.setup{
    use_lsp_diagnostic_signs = true
}
require('gitsigns').setup()

require'nvim-treesitter.configs'.setup {
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
