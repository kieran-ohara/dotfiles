local configs = require "lspconfig.configs"
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

configs.efmLua = {
  default_config = {
    cmd = {
      "efm-langserver",
      "-c",
      os.getenv("XDG_CONFIG_HOME") .. "/efm-langserver/lua.yaml"
    },
    root_dir = util.find_git_ancestor,
    single_file_support = true,
    filetypes = { "lua" },
    init_options = {
      codeAction = false,
      completion = false,
      documentFormatting = true,
      documentRangeFormatting = true,
      documentSymbol = true,
      hover = false
    }
  }
}

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
lspconfig.efmLua.setup {
  capabilities = client_capabilities
}
