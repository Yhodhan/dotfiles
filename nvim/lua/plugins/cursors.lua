-- in ~/.config/nvim/lua/plugins.lua or your LazyVim plugin config
return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    keys = {
      { "<M-u>", "<Plug>(VM-Add-Cursor-Up)", mode = { "n", "v" } },
      { "<M-b>", "<Plug>(VM-Add-Cursor-Down)", mode = { "n", "v" } },
    },
    config = function()
      vim.g.VM_maps = {
        ["Add Cursor Up"] = "<M-u>",
        ["Add Cursor Down"] = "<M-b>",
      }
    end,
  },
}
