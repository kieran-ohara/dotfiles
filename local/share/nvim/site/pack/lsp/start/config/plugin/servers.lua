-- vim: set foldmethod=marker foldlevel=0 modeline:
-- Typescript {{{
vim.lsp.enable('tsc')
-- }}}
-- Terraform {{{
vim.lsp.enable('terraformls')
-- }}}
-- EFM {{{
local efm_log = vim.env.XDG_STATE_HOME .. "/efm-langserver/logs/all.log"
vim.fn.mkdir(vim.fn.fnamemodify(efm_log, ":h"), "p")

vim.lsp.config('efmWithFormat', {
    cmd = {"efm-langserver", "-logfile", efm_log},
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
    cmd = {"efm-langserver", "-logfile", efm_log},
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
