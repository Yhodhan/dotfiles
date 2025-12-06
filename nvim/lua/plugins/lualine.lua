return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Remove the clock from the right side (section z)
    opts.sections.lualine_z = {}
    return opts
  end,
}

