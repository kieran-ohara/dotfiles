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

require'lspsaga'.init_lsp_saga()

local eslint_d = {
    lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
    lintSource = 'eslint_d',
    lintStdin = true,
    lintFormats = { '%f(%l,%c): %tarning %m', '%f(%l,%c): %rror %m' },
    lintIgnoreExitCode = true,
    formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}',
    formatStdin = true,
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require'lspconfig'.tsserver.setup{
    capabilities = capabilities
}

require'lspconfig'.efm.setup{
    filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact'},
    init_options = {
        documentFormatting = true,
        documentSymbol = false,
        completion = false,
        codeAction = false,
        hover = false,
    },
    settings = {
        rootMarkers = { 'package.json', '.git/' },
        languages = {
            javascript = { eslint_d },
            javascriptreact = { eslint_d },
        },
    },
}
