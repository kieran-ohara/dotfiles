require 'lspkind'.init {}
require 'lspsaga'.init_lsp_saga()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Enable underline, use default values
  underline = true,
  -- Enable virtual text, override spacing to 4
  virtual_text = {
    spacing = 4,
  },
}
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require 'lspconfig'.tsserver.setup {
  capabilities = capabilities
}

require 'lspconfig'.efm.setup {
  filetypes = {
    'dockerfile',
    'javascript',
    'javascriptreact',
    'lua',
    'markdown',
    'sh',
    'typescript',
    'typescriptreact',
    'yaml',
  },
  -- sent in initializationOptions from nvim to lang server.
  -- see https://github.com/mattn/efm-langserver#configuration
  init_options = {
    documentFormatting = true,
    documentSymbol = false,
    completion = false,
    codeAction = false,
    hover = false,
  },
  -- sent in on_init via workspace/didChangeConfiguration from nvim to lang server.
  -- overrides config.yaml https://github.com/mattn/efm-langserver#configuration
  -- settings = {},
}


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require 'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require('lspconfig').yamlls.setup {
  filetypes = {
    'json',
    'yaml'
  },
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/package.json"] = "package.json",
        ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.20.9-standalone/all.json"] = "/infrastructure/kubernetes/**/*.yml",
      },
    },
  }
}
