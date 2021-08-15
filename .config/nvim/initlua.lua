require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    tags = false;
    spell = false;
    calc = false;
    omni = false;
    nvim_lsp = true;
    nvim_lua = true;
    neorg = true;
  };
}

require'neorg'.setup {
    -- Tell Neorg what modules to load
    load = {
        ["core.defaults"] = {}, -- Load all the default modules
        ["core.norg.concealer"] = {},
        ["core.norg.dirman"] = { -- Manage your directories with Neorg
        config = {
            workspaces = {
                my_workspace = "~/neorg"
            },
            autodetect = true, -- Automatically detect whenever we have entered a subdirectory of a workspace
            autochdir = true, -- Automatically change the directory to the root of the workspace every time
        }
    },
},
}
-- This sets the leader for all Neorg keybinds. It is separate from the regular <Leader>,
-- And allows you to shove every Neorg keybind under one "umbrella".
local neorg_leader = "<Leader>" -- You may also want to set this to <Leader>o for "organization"

-- Require the user callbacks module, which allows us to tap into the core of Neorg
local neorg_callbacks = require('neorg.callbacks')

-- Listen for the enable_keybinds event, which signals a "ready" state meaning we can bind keys.
-- This hook will be called several times, e.g. whenever the Neorg Mode changes or an event that
-- needs to reevaluate all the bound keys is invoked
neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)

    -- Map all the below keybinds only when the "norg" mode is active
    keybinds.map_event_to_mode("norg", {
        n = { -- Bind keys in normal mode

        -- Keys for managing TODO items and setting their states
        { "gtd", "core.norg.qol.todo_items.todo.task_done" },
        { "gtu", "core.norg.qol.todo_items.todo.task_undone" },
        { "gtp", "core.norg.qol.todo_items.todo.task_pending" },
        { "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle" }

    },
}, { silent = true, noremap = true })
end)

require'nvim-treesitter.configs'.setup {
    ensure_installed = {},
    incremental_selection = {
        enable = true;
    },
    indent = {
        enable = true,
    },
    highlight = {
        enable = true,
    },
}
require "nvim-treesitter.configs".setup {
  playground = {
    enable = false,
  }
}
require'lspkind'.init{}
require'trouble'.setup{
    use_lsp_diagnostic_signs = true
}
require('gitsigns').setup()

require'nvim-treesitter.configs'.setup {
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                -- ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                -- ["aa"] = "@parameter.outer", it does not work!
                ["ia"] = "@parameter.inner",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>sl"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>sh"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                -- ["]]"] = "@class.outer",
            },
            goto_next_end = {
                -- ["]M"] = "@function.outer",
                -- ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                -- ["[["] = "@class.outer",
            },
            goto_previous_end = {
                -- ["[M"] = "@function.outer",
                -- ["[]"] = "@class.outer",
            },
        },
    },
}
