-- No vi compatibility mode
vim.o.compatible = false

-- Leader key
vim.g.mapleader = " "

-- Enable filetype
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

-- GUI font
vim.o.guifont = "Noto Sans Mono:h11"

-- Line settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.api.nvim_command("highlight CursorLine cterm=NONE ctermbg=237 ctermfg=NONE guibg=#44475A")
vim.api.nvim_command("highlight CursorLineNR cterm=NONE ctermbg=237 guibg=#44475A")
vim.o.linespace = 2

-- Tabs settings
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Buffer settings
vim.o.hidden = true
vim.o.laststatus = 2
vim.o.autoread = true
vim.o.scrolloff = 7
vim.o.ruler = true

-- Search settings
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true
vim.o.matchtime = 2

-- Wildmenu settings
vim.o.wildmenu = true
vim.o.wildignore = "*.o,*.swp,*.pyc,.git*"

-- Per-project vimrc
vim.o.exrc = true
vim.o.secure = true

-- Disable swap files
vim.o.backup = false
vim.o.swapfile = false
vim.o.writebackup = false

-- Spelling
vim.o.spelllang = "en"
vim.o.spellsuggest = "best,10"

-- Key mappings
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true })

-- Enable mouse
vim.o.mouse = "a"

-- Whitespace characters
vim.o.listchars = "eol:$,tab:>.,trail:~,space:."
vim.api.nvim_set_keymap("n", "<Leader>w", ":set list!<CR>", { noremap = true })

-- Miscellaneous
vim.o.magic = true
vim.o.encoding = "utf8"
vim.o.backspace = "2"

-- Line moving
-- vim.api.nvim_set_keymap('n', '<C-j>', ':m .+1<CR>==', {noremap = true})
-- Normal mode mappings for moving lines up and down
vim.api.nvim_set_keymap("n", "<C-j>", ":m .+1<CR>==", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":m .-2<CR>==", { noremap = true })

-- Insert mode mappings for moving lines up and down
vim.api.nvim_set_keymap("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { noremap = true })

-- Visual mode mappings for moving lines up and down
vim.api.nvim_set_keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", { noremap = true })

-- Buffer directory expansion
vim.cmd("cabbr <expr> %% expand('%:p:h')")

-- YAML settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  command = "setlocal indentkeys-=0#",
})

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

-- lazy plugins
-- TODO: move to lua/ directory
require("lazy").setup({
  "nvim-treesitter/nvim-treesitter",
  "Mofiqul/dracula.nvim",
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "neovim/nvim-lspconfig",
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
})

-- plugin setup
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- Color scheme
vim.o.syntax = "on"
vim.cmd("colorscheme dracula")
vim.o.background = "dark"

-- Treesitter
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

-- nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})


local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lspconfig
local lspconfig = require("lspconfig")
lspconfig.rust_analyzer.setup {
  capabilities = capabilities
}

