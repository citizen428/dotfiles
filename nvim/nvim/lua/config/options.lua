local o = vim.opt

-- Display
require("vim._core.ui2").enable()
o.colorcolumn = "100"
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

-- Autocomplete
o.autocomplete = true
o.pumborder = "rounded"
o.completeopt = "menu,menuone,noselect,popup"

-- Misc
o.clipboard = "unnamedplus"
o.mouse = "a"
o.swapfile = false
o.wildmode = "noselect:full"
