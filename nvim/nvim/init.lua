local o = vim.opt

-- Display
o.cursorline = true
o.number = true
o.relativenumber = true
o.showmatch = true
o.signcolumn = "yes"
o.winborder = "rounded"

-- Indentation
o.smartindent = true
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2

-- Scrolling
o.scrolloff = 2
o.sidescrolloff = 2

-- Search
o.ignorecase = true
o.smartcase = true

-- Whitespace display
o.list = true
o.listchars = "trail:␣,tab:»\\"

-- Folding
o.foldmethod = "indent"
o.foldlevel = 1
o.foldlevelstart = 99
o.foldcolumn = "1"

-- Misc
o.clipboard = "unnamedplus"
o.mouse = "a"
o.swapfile = false
o.wildmode = "list:longest,full"

-- Plugins and plugin config
vim.pack.add({
  { src = "https://github.com/gbprod/nord.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/chentoast/marks.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/nvim-mini/mini.completion" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/nvim-mini/mini.snippets" },
  { src = "https://github.com/nvim-mini/mini.statusline" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/kylechui/nvim-surround" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/folke/which-key.nvim" },
})

vim.cmd("colorscheme nord")

vim.lsp.enable({ "efm", "lua_ls", "ocaml-lsp", "ts_ls" })

require("marks").setup()
require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "efm",
    "lua-language-server",
    "prettier",
    "stylua",
    "typescript-language-server",
  },
})
require("mini.completion").setup()
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.pick").setup()
require("mini.statusline").setup()
require("oil").setup({
  delete_to_trash = true,
  view_options = { show_hidden = true },
  skip_confirm_for_simple_edits = true,
})
require("nvim-surround").setup()

-- Autocommands
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("LspConfig", { clear = true }),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    if
        client:supports_method("textDocument/formatting") or client:supports_method("textDocument/rangeFormatting")
    then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("FormatOnSave", {}),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })
  end,
})

-- Key mappings
vim.g.mapleader = " "

local wk = require("which-key")
wk.setup()
wk.add({
  { "<leader>c", group = "Code" },
  { "<leader>f", group = "Find" },
  { "<leader>s", "<cmd>source $MYVIMRC<CR>", desc = "Reload config", icon = "󰒓" },
})

local keymap = vim.keymap
keymap.set("i", "jk", "<Esc>")
keymap.set("n", "\\", ":Oil<CR>")
keymap.set("n", "<leader>q", ":quit<CR>", { desc = "Quit" })
keymap.set("n", "<leader>fb", ":Pick buffers<CR>")
keymap.set("n", "<leader>ff", ":Pick files<CR>")
keymap.set("n", "<leader>fg", ":Pick grep_live<CR>")
keymap.set("n", "<leader>fh", ":Pick help<CR>")
keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format buffer" })
keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show diagnostic float" })

-- Confirm completion with Enter
keymap.set("i", "<CR>", function()
  return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true })

-- Tab selects next completion
keymap.set("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

-- Shift-Tab selects previous completion
keymap.set("i", "<S-Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true })

-- Trigger mini.completion with C-x C-o
keymap.set("i", "<C-x><C-o>", [[<Cmd>lua MiniCompletion.complete_twostage()<CR>]])

-- Fix common typo
vim.cmd("cabbrev Wq wq")
