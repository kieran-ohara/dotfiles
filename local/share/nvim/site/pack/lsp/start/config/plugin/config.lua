-- vim: set foldmethod=marker foldlevel=0 modeline:

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    signs = true,
    virtual_text = false
  }
)

require "lspsaga".setup({
  finder = {
    keys = {
      shuttle = '<TAB>',
      toggle_or_open = 'i',
      vsplit = 'v',
    }
  }
})
vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })

-- code action.
vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action"})

-- hover documentation.
-- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "LSP Hover Doc" })

-- peek definition
vim.keymap.set("n", "<leader>lD", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })

-- jump forward/back through errors.
vim.keymap.set("n", "[w", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Next LSP Warning"})
vim.keymap.set("n", "]w", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Previous LSP Warning"})

-- shows the references.
vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", { desc = "References" })

-- set up definition.
vim.keymap.set("n", "<leader>ld", ":lua vim.lsp.buf.definition()<CR>", { desc = "Goto Definition" })

-- Trouble {{{
require"trouble".setup {
  auto_preview = false,
}

-- }}}
