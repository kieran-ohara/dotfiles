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

require'lspconfig'.tsserver.setup{}
require'lspconfig'.efm.setup{
    filetypes = {'javascriptreact'},
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
            javascriptreact = { eslint_d },
        },
    },
}
