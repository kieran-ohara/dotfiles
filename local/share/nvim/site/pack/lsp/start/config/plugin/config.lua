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

-- Only attach if lsp server supports capability
local function any_client_supports(capability)
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    if client.supports_method(capability) then
      return true
    end
  end
  return false
end

-- Always attach this
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc="Info" })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local default_opts = { noremap = true, silent = true, buffer = bufnr }
    local function merge_opts(desc)
      return vim.tbl_extend('force', default_opts, { desc = desc })
    end

    if (any_client_supports("textDocument/rename")) then
      vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", merge_opts("Rename"))
    end

    if (any_client_supports("textDocument/codeAction")) then
      vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", merge_opts("Code Action"))
    end

    if (any_client_supports("textDocument/definition")) then
      vim.keymap.set("n", "<leader>lD", "<cmd>Lspsaga peek_definition<CR>", merge_opts("Peek Definition"))
      vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, merge_opts("Goto Definition"))
    end

    if (any_client_supports("textDocument/publishDiagnostics")) then
      vim.keymap.set("n", "[w", "<cmd>Lspsaga diagnostic_jump_prev<CR>", merge_opts("Next LSP Warning"))
      vim.keymap.set("n", "]w", "<cmd>Lspsaga diagnostic_jump_next<CR>", merge_opts("Previous LSP Warning"))
    end

    if (any_client_supports("textDocument/references")) then
      vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", merge_opts("References"))
    end
  end,
})

-- Trouble {{{
require"trouble".setup {
  auto_preview = false,
}

-- }}}
