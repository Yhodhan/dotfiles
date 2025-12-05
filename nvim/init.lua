-- Doom-like Neovim Configuration (Single-file)
-- Drop this entire file into: ~/.config/nvim/init.lua

------------------------------------------------------------
-- 0. Bootstrap lazy.nvim
------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

------------------------------------------------------------
-- 1. Options (minimal Doom-like defaults)
------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.updatetime = 200

------------------------------------------------------------
-- 2. Plugins
------------------------------------------------------------
require("lazy").setup({

  ----------------------------------------------------------
  -- UI
  ----------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({})
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({})
--      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "tanvirtin/monokai.nvim",
    lazy = false,   -- load immediately
    config = function()
      vim.o.termguicolors = true         -- enable true colors
      require("monokai").setup({
      palette = require("monokai").pro  -- optional, choose palette variant
    })
 --   vim.cmd.colorscheme("monokai")
   end,
  },

{
  "LunarVim/horizon.nvim",
  lazy = false,  -- load at startup
  config = function()
    vim.o.termguicolors = true  -- enable true colors

    require("horizon").setup({
      -- optional settings
      bold = true,
      italic = true,
      underline = true,
      -- you can add more options here if needed
    })

    vim.cmd.colorscheme("colorscheme horizon")
  end,
},

  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  },

  ----------------------------------------------------------
  -- Editing (Doom-like motions)
  ----------------------------------------------------------
  "tpope/vim-repeat",
  "kylechui/nvim-surround",
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "ggandor/leap.nvim",
    config = function()
      -- Updated: use leap's recommended mappings
      local leap = require("leap")
      -- Temporary fix: use old mapping until updated
      -- require('leap').add_default_mappings(true)

-- Jump forward within current window
	vim.keymap.set({'n','x','o'}, 's', function()
  	leap.leap({ target_windows = { vim.api.nvim_get_current_win() } })
	end)

-- Jump backward within current window
	vim.keymap.set({'n','x','o'}, 'S', function()
  	leap.leap({ backward = true, target_windows = { vim.api.nvim_get_current_win() } })
	end)

    end,
  },

  ----------------------------------------------------------
  -- Telescope (SPC f)
  ----------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local wk = require("which-key")
      wk.register({
        f = {
          f = { "<cmd>Telescope find_files<CR>", "Find files" },
          g = { "<cmd>Telescope live_grep<CR>", "Grep" },
          b = { "<cmd>Telescope buffers<CR>", "Buffers" },
        },
      }, { prefix = "<leader>" })
      require("telescope").setup({})
    end,
  },

  ----------------------------------------------------------
  -- File tree (Neo-tree)
  ----------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({})
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")
    end,
  },

  ----------------------------------------------------------
  -- Treesitter (syntax + highlight)
  ----------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- ensure_installed = { "lua_ls", "pyright", "ts_ls" },
	ensure_installed = { "lua", "python", "typescript", "javascript" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  ----------------------------------------------------------
  -- LSP (Doom :lsp module)
  ----------------------------------------------------------
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "mason.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Updated for new LSP API
      local lspconfig = vim.lsp.config
      -- Revert to stable lspconfig for now
      -- local lspconfig = require('lspconfig')
      -- lspconfig.lua_ls.setup({})(lspconfig.lua_ls())({})
      -- local lspconfig = require('lspconfig')
      -- vim.lsp.config.lua_ls.setup({})
      -- vim.lsp.enable("lua_ls")

      local config = vim.lsp.config
      vim.lsp.enable('lua_ls', config.lua_ls)

    end,
  },

  ----------------------------------------------------------
  -- Completion (Doom's :completion)
  ----------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        }),
      })
    end,
  },

  ----------------------------------------------------------
  -- Org-like system (Neorg)
  ----------------------------------------------------------
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      })
    end,
  },
  ----------------------------------------------------------
  -- Multicursors
  ----------------------------------------------------------
  {
   "mg979/vim-visual-multi",
    branch = "master",
    keys = {
      {"<A-u>", "<Plug>(VM-Add-Cursor-Up)"},
      {"<A-b>", "<Plug>(VM-Add-Cursor-Down)"},
    },
    config = function()
     vim.g.VM_maps = vim.g.VM_maps or {}
     vim.g.VM_maps['AddCursorUp'] = '<A-u>'
     vim.g.VM_maps['AddCursorDown'] = '<A-b>'
   end
}


})

------------------------------------------------------------
-- 3. Keybinds (Doom-like global maps)
------------------------------------------------------------
local map = vim.keymap.set

vim.keymap.set("n", "<A-m>", ":Neotree toggle reveal<CR>", {
  desc = "Toggle Neo-tree file explorer",
})

require("neo-tree").setup({
  window = {
    mappings = {
      ["<Tab>"] = "open",        -- TAB to open file in current window
      ["<S-Tab>"] = "open_split",-- Shift+TAB opens in horizontal split
    },
  },
})

local wk = require("which-key")

wk.register({
  q = {
    name = "+quit",       -- optional group name
    q = { "<cmd>qa<CR>", "Quit all" },
  },
}, { prefix = "<leader>" })

-- Buffers
map("n", "<leader>bd", ":bdelete<CR>")

-- Windows
map("n", "<leader>ws", "<C-w>s")
map("n", "<leader>wv", "<C-w>v")

-- Git placeholder (add LazyGit if installed)
map("n", "<leader>gg", ":LazyGit<CR>")

-- Projects (Telescope)
map("n", "<leader>pp", ":Telescope projects<CR>")

-- Vertical split: Alt+v + p
vim.keymap.set("n", "vp", ":vsplit<CR>", { desc = "Vertical split" })

-- Horizontal split: Alt+s + p
vim.keymap.set("n", "sp", ":split<CR>", { desc = "Horizontal split" })

-- Alt+o to move to the next window
vim.keymap.set("n", "<A-o>", "<C-w>w", { desc = "Cycle through windows" })

-- Alt+q to close the current pane
vim.keymap.set("n", "qq", "<C-w>c", { desc = "Close current pane" })

-- List buffers like Emacs SPC b b
vim.keymap.set("n", "<leader>bb", ":Telescope buffers<CR>", { desc = "List open buffers" })
 

-- LSP

require("plugins.lsp")
