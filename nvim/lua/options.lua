require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local o = vim.o
-- Enable treesitter folding
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
