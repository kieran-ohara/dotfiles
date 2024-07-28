# I install my parsers outside of nvim.
vim.opt.runtimepath:append(vim.env.XDG_CACHE_HOME .. "/parsers/lib")

require 'nvim-treesitter.configs'.setup {
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
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ar"] = "@parameter.outer",
        ["ir"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["]s"] = "@parameter.inner",
      },
      swap_previous = {
        ["[s"] = "@parameter.inner",
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

require("aerial").setup({
  backends = { "treesitter" },
  manage_folds = false,
})
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle<cr>")
