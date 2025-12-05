return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "
      require("which-key").setup({})
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({})
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },
}

