-- Only help, lua, query and markdown start a highlighter from a bundled
-- ftplugin; every other filetype needs asking. pcall covers the filetypes
-- with no parser installed.
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args) pcall(vim.treesitter.start, args.buf) end
})

require("nvim-treesitter-textobjects").setup {
    select = {
        lookahead = true,
        keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ar"] = "@parameter.outer",
            ["ir"] = "@parameter.inner"
        }
    },
    swap = {
        swap_next = {["]s"] = "@parameter.inner"},
        swap_previous = {["[s"] = "@parameter.inner"}
    },
    move = {
        set_jumps = true,
        goto_next_start = {["]m"] = "@function.outer"},
        goto_previous_start = {["[m"] = "@function.outer"}
    }
}

require("aerial").setup({
    backends = {"treesitter"},
    manage_folds = false,
    nerd_font = true
})
vim.keymap.set("n", "<leader>ta", "<cmd>AerialToggle<cr>",
               {desc = "Toggle Aerial"})
vim.keymap.set("n", "<leader>tp", "<cmd>InspectTree<cr>",
               {desc = "Toggle Tree Inspector"})
