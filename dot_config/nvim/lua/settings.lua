-- No vi compatibility mode
vim.o.compatible = false

-- Leader key
vim.g.mapleader = " "

-- Color scheme
vim.o.syntax = "on"
-- vim.cmd("colorscheme slate")
vim.o.background = "dark"
vim.o.termguicolors = true

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable filetype
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

-- GUI font
vim.o.guifont = "Noto Sans Mono:h10"
-- vim.o.guifont = "NotoMono Nerd Font;h10"

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

-- Enable mouse
vim.o.mouse = "a"

-- Whitespace characters
vim.o.listchars = "eol:$,tab:>.,trail:~,space:."

-- Miscellaneous
vim.o.magic = true
vim.o.encoding = "utf8"
vim.o.backspace = "2"

-- Buffer directory expansion
vim.cmd("cabbr <expr> %% expand('%:p:h')")
