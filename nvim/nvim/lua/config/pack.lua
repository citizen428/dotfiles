local gh = function(x)
  return "https://github.com/" .. x
end

vim.pack.add({
  gh("gbprod/nord.nvim"),
  gh("neovim/nvim-lspconfig"),
  gh("chentoast/marks.nvim"),
  gh("mason-org/mason.nvim"),
  gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
  gh("nvim-mini/mini.icons"),
  gh("nvim-mini/mini.extra"),
  gh("nvim-mini/mini.pairs"),
  gh("nvim-mini/mini.pick"),
  gh("nvim-mini/mini.snippets"),
  gh("rafamadriz/friendly-snippets"),
  gh("kylechui/nvim-surround"),
  gh("chomosuke/typst-preview.nvim"),
  gh("stevearc/oil.nvim"),
  gh("folke/which-key.nvim"),
  gh("obsidian-nvim/obsidian.nvim"),
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
require("mini.extra").setup()
require("mini.pairs").setup()
require("mini.pick").setup()
require("oil").setup({
  delete_to_trash = true,
  view_options = { show_hidden = true },
  skip_confirm_for_simple_edits = true,
})
require("nvim-surround").setup()
require("typst-preview").setup()
require("obsidian").setup({
  legacy_commands = false,
  workspaces = {
    { name = "defaut", path = "~/Documents/Obsidian Vault" },
  },
})
