return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local wk = require("which-key")

    telescope.setup({})

    wk.register({
      f = {
        f = { "<cmd>Telescope find_files<CR>", "Find file" },
        g = { "<cmd>Telescope live_grep<CR>", "Grep" },
        b = { "<cmd>Telescope buffers<CR>", "Buffers" },
      },
    }, { prefix = "<leader>" })
  end,
}
