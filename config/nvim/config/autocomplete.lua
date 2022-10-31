-- vim: set foldmethod=marker foldlevel=0 modeline:
-- {{{ cmp
local lspkind = require("lspkind")
local cmp = require "cmp"
cmp.setup(
  {
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources(
      {
        { name = 'nvim_lsp_signature_help' },
        { name = "nvim_lsp" },
        { name = "vsnip" },
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
-- }}}
-- Autopairs {{{
require("nvim-autopairs").setup {
  check_ts = true
}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
-- }}}
-- Vsnips {{{
vim.cmd([[
  let g:vsnip_snippet_dirs = [ '~/.config/nvim/pack/autocomplete/start/friendly-snippets' ]
  let g:vsnip_filetypes = {}
]])
-- }}}
