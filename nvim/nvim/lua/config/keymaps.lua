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
keymap.set("n", "<leader>fn", ":Obsidian quick_switch<CR>")
keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format buffer" })
keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show diagnostic float" })
keymap.set("n", "<leader>cD", vim.diagnostic.setloclist, { desc = "Show diagnostics" })
keymap.set("n", "<leader>u", function()
  require("undotree").open({ command = ":rightbelow 30vnew" })
end)

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

-- Fix common typo
vim.cmd("cabbrev Wq wq")
