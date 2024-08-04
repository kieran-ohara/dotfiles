-- vim: set foldmethod=marker foldlevel=0 modeline:
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require "lspconfig".tsserver.setup {
  capabilities = capabilities,
  init_options = {
    tsserver = {
      fallbackPath = os.getenv("XDG_DATA_HOME") .. "/mise/installs/npm-typescript/latest/lib/node_modules/typescript/lib"
    }
  }
}
require'lspconfig'.terraformls.setup{
  capabilities = capabilities
}
-- EFM {{{
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"
local configs = require "lspconfig.configs"

configs.efmWithFormat = {
  default_config = {
    cmd = {"efm-langserver"},
    root_dir = util.find_git_ancestor,
    single_file_support = true,
    filetypes = {
      "sh",
    },
    init_options = {
      documentFormatting = true,
      hover = true,
      documentSymbol = true,
      codeAction = true,
      completion = true
    }
  }
}
lspconfig.efmWithFormat.setup {
  capabilities = capabilities
}

configs.efmNoFormat = {
  default_config = {
    cmd = {"efm-langserver"},
    root_dir = util.find_git_ancestor,
    single_file_support = true,
    filetypes = {
      "dockerfile",
      "markdown",
      "yaml"
    },
    init_options = {
      documentFormatting = false,
      hover = true,
      documentSymbol = true,
      codeAction = true,
      completion = true
    }
  }
}
lspconfig.efmNoFormat.setup {
  capabilities = capabilities
}
-- }}}
-- YAML {{{
require("lspconfig").yamlls.setup {
  capabilities = capabilities,
  filetypes = {
    "json",
    "yaml"
  },
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/package.json"] = "package.json",
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.20.9-standalone/all.json"] = "/infrastructure/kubernetes/**/*.yml"
      }
    }
  }
}
-- }}}
