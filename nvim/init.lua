-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- after: colorscheme horizon
vim.api.nvim_set_hl(0, "Normal",      { bg = "#262f33" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#262f33" })
vim.api.nvim_set_hl(0, "SignColumn",  { bg = "#262f33" })
vim.api.nvim_set_hl(0, "LineNr",      { bg = "#262f33" })

-- Make line numbers dimmer
vim.api.nvim_set_hl(0, "LineNr",        { fg = "#444444" })   -- dim grey
--vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#222222" })   -- slightly brighter (optional)

vim.o.guicursor = table.concat({
  "n-v-c:block-blinkwait700-blinkon400-blinkoff400",
  "i-ci:ver25-blinkwait700-blinkon300-blinkoff300",
  "r:hor20-blinkwait700-blinkon300-blinkoff300",
}, ",")

-- remove the vertical split line
vim.o.fillchars = "vert: "
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE", fg = "NONE" })

