-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Vertical split: Alt+v + p
vim.keymap.set("n", "vp", ":vsplit<CR>", { desc = "Vertical split" })

-- Horizontal split: Alt+s + p
vim.keymap.set("n", "sp", ":split<CR>", { desc = "Horizontal split" })

-- Alt+o to move to the next window
vim.keymap.set("n", "<A-o>", "<C-w>w", { desc = "Cycle through windows" })

vim.keymap.set("n", "<A-m>", ":Neotree toggle reveal<CR>", {
  desc = "Toggle Neo-tree file explorer",
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Emacs-style window management
map("n", "<C-x>0", "<C-w>c", opts)  -- delete current window
map("n", "<C-x>1", "<C-w>o", opts)  -- delete other windows (only current remains)

-- movement
map("n", "gl", "$", opts)      -- go to end of line
map("n", "gh", "0", opts)      -- go to beginning of line

-- buffer control
map("n", "gn", ":bnext<CR>", opts)     -- next buffer
map("n", "gp", ":bprevious<CR>", opts) -- previous buffer
map("n", "ge", "G", opts)              -- go to end of buffer
map("n", "mm", "%", opts)
map("n", "md", "d%", opts)

-- save file
map("n", "vv", ":w<CR>", opts)   -- save (basic-save-buffer)

-- format buffer (requires LSP)
map("n", "ff", function()
  vim.lsp.buf.format()
end, opts) 

-- Emacs-style window management
map("n", "<C-x>0", "<C-w>c", opts)  -- delete current window
map("n", "<C-x>1", "<C-w>o", opts)  -- delete other windows (only current remains)

vim.keymap.set("n", "<C-o>", function()
  local file = vim.fn.expand("%:t")
  local base = vim.fn.expand("%:r")
  local dir = vim.fn.expand("%:h")

  local candidates = {
    base .. ".cpp",
    base .. ".cc",
    base .. ".c",
    base .. ".cxx",
    base .. ".hpp",
    base .. ".hh",
    base .. ".h",
  }

  for _, target in ipairs(candidates) do
    local full = dir .. "/" .. target
    if full ~= vim.fn.expand("%:p") and vim.fn.filereadable(full) == 1 then
      vim.cmd("edit " .. full)
      return
    end
  end

  print("No matching header/source found")
end, { desc = "Toggle between header/source" })

