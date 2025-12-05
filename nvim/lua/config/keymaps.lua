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

