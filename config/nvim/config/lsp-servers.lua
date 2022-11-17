-- vim: set foldmethod=marker foldlevel=0 modeline:
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require "lspconfig".tsserver.setup {
  capabilities = capabilities
}
require'lspconfig'.vuels.setup{
  capabilities = capabilities
}
require'lspconfig'.terraformls.setup{
  capabilities = capabilities
}
require'lspconfig'.gopls.setup {
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
      "javascript",
      "javascriptreact",
      "lua",
      "markdown",
      "typescript",
      "typescriptreact",
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
-- Lua {{{
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require "lspconfig".sumneko_lua.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"}
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true)
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false
      }
    }
  }
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
