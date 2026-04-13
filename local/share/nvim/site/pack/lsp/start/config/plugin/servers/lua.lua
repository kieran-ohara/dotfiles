vim.lsp.config('efmLua', {
    cmd = {
        "efm-langserver", "-c",
        os.getenv("XDG_CONFIG_HOME") .. "/efm-langserver/lua.yaml"
    },
    root_markers = {".git"},
    filetypes = {"lua"},
    init_options = {
        codeAction = false,
        completion = false,
        documentFormatting = true,
        documentRangeFormatting = true,
        documentSymbol = true,
        hover = false
    }
})
vim.lsp.enable('efmLua')
