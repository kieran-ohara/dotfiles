-- vim: set foldmethod=marker foldlevel=0 modeline:
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config('*', {capabilities = capabilities})

-- Typescript {{{
vim.lsp.config('ts_ls', {
    init_options = {
        tsserver = {
            path = os.getenv("XDG_DATA_HOME") ..
                "/mise/installs/npm-typescript/latest/lib/node_modules/typescript/lib"
        }
    }
})
vim.lsp.enable('ts_ls')
-- }}}
-- Terraform {{{
vim.lsp.enable('terraformls')
-- }}}
-- EFM {{{
vim.lsp.config('efmWithFormat', {
    cmd = {"efm-langserver"},
    root_markers = {".git"},
    filetypes = {"sh"},
    init_options = {
        documentFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true
    }
})
vim.lsp.enable('efmWithFormat')

vim.lsp.config('efmNoFormat', {
    cmd = {"efm-langserver"},
    root_markers = {".git"},
    filetypes = {"dockerfile", "markdown", "yaml"},
    init_options = {
        documentFormatting = false,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true
    }
})
vim.lsp.enable('efmNoFormat')
-- }}}
-- YAML {{{
vim.lsp.config('yamlls', {
    filetypes = {"json", "yaml"},
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/package.json"] = "package.json",
                ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.20.9-standalone/all.json"] = "/infrastructure/kubernetes/**/*.yml"
            }
        }
    }
})
vim.lsp.enable('yamlls')
-- }}}
