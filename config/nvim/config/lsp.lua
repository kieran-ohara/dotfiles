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

-- LSP Saga {{{
require "lspsaga".setup({})
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", { desc = "LSP Rename" })

-- code action.
vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>", { desc = "LSP Code Action"})

-- hover documentation.
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "LSP Hover Doc" })

-- peek definition
vim.keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", { desc = "LSP Peek Def" })

-- jump forward/back through errors.
vim.keymap.set("n", "[w", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "LSP Jump Prev"})
vim.keymap.set("n", "]w", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "LSP Jump Next"})

-- shows the references.
vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", { desc = "LSP References" })

-- }}}
-- Trouble {{{
require"trouble".setup {
  auto_preview = false,
}

vim.keymap.set("n", "<leader>t", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
-- }}}
