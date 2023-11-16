-- exit insert mode
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true })

-- show whitespace chars
vim.api.nvim_set_keymap("n", "<Leader>w", ":set list!<CR>", { noremap = true })

-- Line moving
-- Normal mode mappings for moving lines up and down
vim.api.nvim_set_keymap("n", "<C-j>", ":m .+1<CR>==", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":m .-2<CR>==", { noremap = true })

-- Insert mode mappings for moving lines up and down
vim.api.nvim_set_keymap("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { noremap = true })

-- Visual mode mappings for moving lines up and down
vim.api.nvim_set_keymap("v", "<C-j>", ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("v", "<C-k>", ":m '<-2<CR>gv=gv", { noremap = true })

-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
