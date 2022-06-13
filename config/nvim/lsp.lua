-- vim: set foldmethod=marker foldlevel=0 modeline:
require "lspkind".init {}
require "lspsaga".init_lsp_saga()

require("trouble").setup {}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = {
      spacing = 4
    }
  }
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require "lspconfig".tsserver.setup {
  capabilities = capabilities
}
require'lspconfig'.vuels.setup{}

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
      "lua",
      "sh"
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
lspconfig.efmWithFormat.setup {}

configs.efmNoFormat = {
  default_config = {
    cmd = {"efm-langserver"},
    root_dir = util.find_git_ancestor,
    single_file_support = true,
    filetypes = {
      "dockerfile",
      "javascript",
      "javascriptreact",
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
lspconfig.efmNoFormat.setup {}
-- }}}
-- Lua {{{
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require "lspconfig".sumneko_lua.setup {
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
