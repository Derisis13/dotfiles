require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
map({ "n", "v", "x" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { desc = "General Move down", expr = true })
map({ "n", "v", "x" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { desc = "General Move up", expr = true })
map(
  { "n", "v", "x" },
  "<Up>",
  'v:count || mode(1)[0:1] == "no" ? "k" : "gk"',
  { desc = "General Move up", expr = true }
)
map(
  { "n", "v", "x" },
  "<Down>",
  'v:count || mode(1)[0:1] == "no" ? "j" : "gj"',
  { desc = "General Move down", expr = true }
)

-- Don't escape visual mode when indenting
map("v", "<", "<gv", { desc = "General Decrease indent" })
map("v", ">", ">gv", { desc = "General Increase indent" })

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "General Don't copy replaced text", silent = true })

-- format with conform
map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "formatting" })

-- Trim trailing spaces
map("n", "<leader>s", function()
  local curpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd [[keeppatterns %s/\s\+$//e]]
  vim.api.nvim_win_set_cursor(0, curpos)
end, { desc = "Shortcuts Trim trailing whitespaces" })

-- Tabularize
map("n", "<Leader>t:", ":Tabularize /^[^:]*\\zs:<CR>", { desc = "Shortcuts tabularize :" })
map("n", "<Leader>t=", ":Tabularize /^[^7]*\\zs=><CR>", { desc = "Shortcuts tabularize =>" })
map(
  "n",
  "<Leader>ti",
  ":Tabularize /\\(\\<in\\>\\|\\<out\\>\\|\\<buffer\\>\\)<CR>",
  { desc = "Shortcuts tabularize port directions" }
)
map("v", "<Leader>t:", ":GTabularize /^[^:]*\\zs:<CR>", { desc = "Shortcuts block tabularize :" })
map("v", "<Leader>t=", ":GTabularize /^[^=]*\\zs=><CR>", { desc = "Shortcuts block tabularize =>" })
map(
  "v",
  "<Leader>ti",
  ":GTabularize /\\(\\<in\\>\\|\\<out\\>\\|\\<buffer\\>\\)<CR>",
  { desc = "Shortcuts block tabularize port directions" }
)

-- Gitsigns
map("n", "]c", function()
  if vim.wo.diff then
    return "]c"
  end
  vim.schedule(function()
    require("gitsigns").next_hunk()
  end)
  return "<Ignore>"
end, { desc = "Gitsigns Jump to next hunk", expr = true })

map("n", "[c", function()
  if vim.wo.diff then
    return "[c"
  end
  vim.schedule(function()
    require("gitsigns").prev_hunk()
  end)
  return "<Ignore>"
end, { desc = "Gitsigns Jump to prev hunk", expr = true })

map("n", "<leader>rh", function()
  require("gitsigns").reset_hunk()
end, { desc = "Gitsigns Reset hunk" })

map("n", "<leader>ph", function()
  require("gitsigns").preview_hunk()
end, { desc = "Gitsigns Preview hunk" })

map("n", "<leader>gb", function()
  package.loaded.gitsigns.blame_line()
end, { desc = "Gitsigns Blame line" })

map("n", "<leader>td", function()
  require("gitsigns").toggle_deleted()
end, { desc = "Gitsigns Toggle deleted" })

-- molten related mappings
map("n", "<localleader>ip", function()
  local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
  if venv ~= nil then
    -- in the form of /home/ha5pls/.local/state/virtualenvs/VENV_NAME
    venv = string.match(venv, "/.+/(.+)")
    vim.cmd(("MoltenInit %s"):format(venv))
  else
    vim.cmd("MoltenInit python3")
  end
end, { desc = "Initialize Molten for python3" })
map("n", "<leader>mi", ":MoltenInit<CR>")
map("n", "<leader>me", ":MoltenEvaluateOperator<CR>")
map("n", "<leader>rr", ":MoltenReevaluateCell<CR>")
map("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>gv")
map("n", "<leader>os", ":noautocmd MoltenEnterOutput<CR>")
map("n", "<leader>oh", ":MoltenHideOutput<CR>")
map("n", "<leader>md", ":MoltenDelete<CR>")
