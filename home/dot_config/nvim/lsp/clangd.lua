return {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  root_dir = vim.fs.root(0, { "Makefile" }),
}
