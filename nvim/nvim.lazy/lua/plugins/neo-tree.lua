return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- optional
      "MunifTanjim/nui.nvim",
    },

    opts = function(_, opts)
      -- merge your custom options into lazyvim defaults
      opts.close_if_last_window = true
      opts.popup_border_style = "rounded"
      opts.enable_git_status = true
      opts.enable_diagnostics = true

      -- ensure window table exists
      opts.window = opts.window or {}

      -- ensure mappings table exists
      opts.window.mappings = vim.tbl_extend("force", opts.window.mappings or {}, {
        ["<Tab>"] = {
          "toggle_node",
          desc = "Expand/Collapse folder",
        },
      })

      return opts
    end,
  },
}

