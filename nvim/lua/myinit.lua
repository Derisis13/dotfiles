local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Auto unfold all when entering a buffer
autocmd("BufWinEnter", { pattern = "*", command = "silent! :%foldopen!" })

vim.g.vscode_snippets_path = "~/.config/nvim/snippets"
vim.opt.relativenumber = true
