local lspkind = require("lspkind")

local cmp = require "cmp"
cmp.setup(
  {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({}),
    sources = cmp.config.sources(
      {
        { name = "nvim_lsp" },
        { name = "buffer" }
      }
    ),
    formatting = {
      format = lspkind.cmp_format(
        {
          mode = "symbol_text", -- show only symbol annotations
          maxwidth = 50
        }
      )
    }
  }
)
cmp.setup.cmdline(
  ":",
  {
    sources = cmp.config.sources(
      {
        { name = "path" },
      }
    )
  }
)
