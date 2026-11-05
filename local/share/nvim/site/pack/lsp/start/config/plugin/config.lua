-- vim: set foldmethod=marker foldlevel=0 modeline:
local severity = vim.diagnostic.severity
vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    virtual_lines = {current_line = true},
    signs = {
        text = {
            [severity.ERROR] = "󱎘 ",
            [severity.WARN] = " ",
            [severity.HINT] = "󰌵 ",
            [severity.INFO] = " "
        },
        numhl = {
            [severity.ERROR] = "DiagnosticSignError",
            [severity.WARN] = "DiagnosticSignWarn",
            [severity.HINT] = "DiagnosticSignHint",
            [severity.INFO] = "DiagnosticSignInfo"
        }
    }
})

-- Nothing native reports client state, so this one still does the work.
vim.keymap.set("n", "<leader>li", "<cmd>checkhealth vim.lsp<CR>", {desc = "Info"})

-- Each of these keys now only names the one that replaced it. Pressing it
-- reports the native key and does nothing else, so the habit has to move.
local replaced_by = {
    {lhs = "<leader>ld", native = "<C-]>", also = "g<C-]> to pick between matches"},
    {lhs = "<leader>ln", native = "grn"},
    {lhs = "<leader>la", native = "gra", mode = {"n", "v"}},
    {lhs = "<leader>lr", native = "grr"},
    {lhs = "<leader>lf", native = "gq{motion}", also = "gggqG for the whole buffer"},
    {lhs = "[w", native = "[d"},
    {lhs = "]w", native = "]d"}
}

for _, key in ipairs(replaced_by) do
    local hint = "Use " .. key.native
    vim.keymap.set(key.mode or "n", key.lhs, function()
        vim.notify(key.also and (hint .. ", " .. key.also) or hint,
                   vim.log.levels.WARN)
    end, {desc = hint})
end
