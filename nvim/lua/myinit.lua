local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

autocmd({ "FileType" }, {
    callback = function()

        -- check if treesitter has parser
        if require("nvim-treesitter.parsers").has_parser() then

            -- use treesitter folding
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        else

            -- use alternative foldmethod
            vim.opt.foldmethod = "syntax"
        end
    end,
})

-- disable folding on startup
vim.opt.foldenable = false
-- disable folding on loading
vim.opt.foldlevel = 20

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
