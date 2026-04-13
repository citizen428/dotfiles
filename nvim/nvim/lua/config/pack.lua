vim.pack.add({
  { src = "https://github.com/gbprod/nord.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/chentoast/marks.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/nvim-mini/mini.snippets" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/kylechui/nvim-surround" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
})

-- Built-in plugins
vim.cmd("packadd nvim.undotree")

-- Plugin configs
vim.cmd("colorscheme nord")

vim.lsp.enable({ "clangd", "efm", "gleam", "lua_ls", "ocaml-lsp", "ts_ls", "zls" })

require("marks").setup()
require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "clangd",
    "efm",
    "lua-language-server",
    "prettier",
    "stylua",
    "typescript-language-server",
    "tinymist",
    "zls",
  },
})
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.pick").setup()
require("oil").setup({
  delete_to_trash = true,
  view_options = { show_hidden = true },
  skip_confirm_for_simple_edits = true,
})
require("nvim-surround").setup()
require("typst-preview").setup()
