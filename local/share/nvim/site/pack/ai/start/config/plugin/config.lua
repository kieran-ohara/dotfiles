require("chatgpt").setup({
      predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/kieran-ohara/dotfiles/main/prompts/prompts.csv",
})
vim.keymap.set('n', '<leader>cc', '<cmd>ChatGPT<CR>', {  desc = 'Chat' })
vim.keymap.set('n', '<leader>ce', '<cmd>ChatGPTEditWithInstructions<CR>', {  desc = 'Edit' })
