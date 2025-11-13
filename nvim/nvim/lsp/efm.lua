local prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true,
}

local stylua = {
  formatCommand = "stylua --search-parent-directories --stdin-filepath ${INPUT} -",
  formatStdin = true,
}

return {
  filetypes = { "javascript", "typescript", "json", "javascriptreact", "typescriptreact", "lua" },
  init_options = {
    documentFormatting = true,
  },
  settings = {
    languages = {
      javascript = { prettier },
      typescript = { prettier },
      json = { prettier },
      javascriptreact = { prettier },
      typescriptreact = { prettier },
      lua = { stylua },
    },
  },
}
