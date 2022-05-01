require'lspkind'.init{}
require'lspsaga'.init_lsp_saga()
require'trouble'.setup{ use_lsp_diagnostic_signs = true }

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = {
        spacing = 4,
    },
}
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.tsserver.setup{
    capabilities = capabilities
}

require'lspconfig'.efm.setup{
    filetypes = {
      'dockerfile',
      'javascript',
      'javascriptreact',
      'markdown',
      'sh',
      'typescript',
      'typescriptreact',
      'yaml',
    },
    -- sent in initializationOptions from nvim to lang server.
    -- see https://github.com/mattn/efm-langserver#configuration
    init_options = {
        documentFormatting = true,
        documentSymbol = false,
        completion = false,
        codeAction = false,
        hover = false,
    },
    -- sent in on_init via workspace/didChangeConfiguration from nvim to lang server.
    -- overrides config.yaml https://github.com/mattn/efm-langserver#configuration
    -- settings = {},
}
