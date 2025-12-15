-- ~/.config/nvim/lua/plugins/horizon.lua
return {
  {
    "akinsho/horizon.nvim",
    lazy = false,     -- load it immediately (not lazy)
    priority = 1000,
    name = "horizon",
    config = function()
      require("horizon").setup({})
      vim.cmd("horizon")
    end,
  },
}

