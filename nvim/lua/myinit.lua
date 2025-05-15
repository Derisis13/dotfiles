local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- Auto unfold all when entering a buffer
autocmd("BufWinEnter", { pattern = "*", command = "silent! :%foldopen!" })

-- Hyrplang filetype 
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
-- Hyprlang LSP
autocmd({'BufEnter', 'BufWinEnter'}, {
    pattern = {"*.hl", "hypr*.conf"},
    callback = function(event)
        print(string.format("starting hyprls for %s", vim.inspect(event)))
        vim.lsp.start {
            name = "hyprlang",
            cmd = {"hyprls"},
            root_dir = vim.fn.getcwd(),
        }
    end
})

vim.g.vscode_snippets_path = "~/.config/nvim/snippets"
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- use prepared venv, mostly for molten
local enable_providers = {
      "python3_provider",
      -- and so on
    }
    
    for _, plugin in pairs(enable_providers) do
      vim.g["loaded_" .. plugin] = nil
      vim.cmd("runtime " .. plugin)
    end

vim.g.python3_host_prog = vim.fn.expand(os.getenv("XDG_STATE_HOME") .. "/virtualenvs/neovim/bin/python3")
