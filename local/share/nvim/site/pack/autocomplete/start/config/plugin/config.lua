vim.o.autocomplete = true
vim.o.completeopt = "menuone,noselect,popup"
vim.o.pummaxwidth = 50

-- LSP items reach the menu through 'complete's "o" (omnifunc) flag, so
-- vim.lsp.completion.enable takes no autotrigger: with both, the server fires
-- a second time on its trigger characters. enable() is still what applies
-- snippets, import edits and commands when an item is accepted.
vim.o.complete = ".^5,o^10"
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.completion.enable(true, args.data.client_id, args.buf)
  end
})

-- rhubarb claims the omnifunc in a GitHub repo's commit buffer and spends two
-- issue searches per call, against a search endpoint that allows ten a minute,
-- so reaching it per keystroke rate limits after five characters. Dropping "o"
-- here leaves it on <C-x><C-o>.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function() vim.bo.complete = ".^5" end
})

vim.o.wildmode = "noselect:lastused,full"
vim.api.nvim_create_autocmd("CmdlineChanged", {
  pattern = { ":", "/", "?" },
  callback = function() vim.fn.wildtrigger() end
})

require("nvim-autopairs").setup {
  check_ts = true
}
