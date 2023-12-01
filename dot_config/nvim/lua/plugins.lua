-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- always load these packages
local packages = {
  "nvim-treesitter/nvim-treesitter",
  "Mofiqul/dracula.nvim",
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "luukvbaal/nnn.nvim",
}

if vim.g.neovide then
  local gui_packages = {
    -- git
    "lewis6991/gitsigns.nvim",
    -- lsp
    "neovim/nvim-lspconfig",
    -- cmp
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    -- snip
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    -- neorg
    {
      "nvim-neorg/neorg",
      build = ":Neorg sync-parsers",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("neorg").setup({
          load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.export"] = {},
            ["core.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.dirman"] = { -- Manages Neorg workspaces
              config = {
                workspaces = {
                  notes = "~/docs/neorg",
                },
                default_workspace = "notes",
              },
            },
          },
        })
      end,
    },
    -- todo
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    -- language-specific
    "simrat39/rust-tools.nvim",
    {
      "pmizio/typescript-tools.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      opts = {},
    },
  }

  for _, value in ipairs(gui_packages) do
    table.insert(packages, value)
  end
end

-- lazy plugins
require("lazy").setup(packages)

-- dracula
vim.cmd("colorscheme dracula")

-- treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "rust" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn", -- set to `false` to disable one of the mappings
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
})

-- nvim-tree
require("nvim-tree").setup()

--- nnn
require("nnn").setup({
  explorer = {
    cmd = "nnn -A",
  },
  picker = {
    cmd = "nnn -A",
  },
})

if vim.g.neovide then
  -- gitsigns
  require("gitsigns").setup()

  -- nvim-cmp
  local cmp = require("cmp")

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = "luasnip" }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = "buffer" },
    }),
  })

  -- lsp
  local _border = "single"

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = _border,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = _border,
  })

  vim.diagnostic.config({
    float = { border = _border },
  })

  require("lspconfig.ui.windows").default_options = {
    border = _border,
  }

  -- todo
  require("todo-comments").setup()

  -- rust
  local rt = require("rust-tools")

  rt.setup({
    server = {
      on_attach = function(_, bufnr)
        -- Hover actions
        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      end,
    },
  })

  -- typescript
  require("typescript-tools").setup({
    settings = {
      tsserver_file_preferences = {
        includeInlayParameterNameHints = "all",
        includeCompletionsForModuleExports = true,
        quotePreference = "auto",
      },
      -- tsserver_format_options = {
      --   allowIncompleteCompletions = false,
      --   allowRenameOfImportPath = false,
      -- }
    },
  })
end
