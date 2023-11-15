-- YAML settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "yaml",
  command = "setlocal indentkeys-=0#",
})
