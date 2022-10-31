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
require "lspsaga".init_lsp_saga()
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })

-- code action.
vim.keymap.set({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })

-- hover documentation.
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

-- peek definition
vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- jump forward/back through errors.
vim.keymap.set("n", "[w", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
vim.keymap.set("n", "]w", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- shows the references.
vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- }}}
-- Trouble {{{
require"trouble".setup {
  auto_preview = false,
}

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
-- }}}
