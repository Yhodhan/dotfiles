-- Change the background after loading the colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "horizon",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal",       { bg = "#262f33" })  -- your custom background
    vim.api.nvim_set_hl(0, "NormalFloat",  { bg = "#262f33" })
    vim.api.nvim_set_hl(0, "SignColumn",   { bg = "#262f33" })
    vim.api.nvim_set_hl(0, "LineNr",       { bg = "#262f33" })
  end,
})

