-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- after: colorscheme horizon
vim.api.nvim_set_hl(0, "Normal",      { bg = "#262f33" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#262f33" })
vim.api.nvim_set_hl(0, "SignColumn",  { bg = "#262f33" })
-vim.api.nvim_set_hl(0, "LineNr",      { bg = "#262f33" })

