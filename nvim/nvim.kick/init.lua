-- ============================================================================
-- Basic Neovim options
-- ============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true

vim.opt.winbar = ""

-- Remove statusline (bottom bar)
--
vim.opt.laststatus = 0

-- Remove tabline

vim.opt.showtabline = 0

-- Remove ruler (line,col display)

vim.opt.ruler = false

-- Optional: remove command display

vim.opt.showcmd = false

-- ============================================================================
-- Bootstrap lazy.nvim
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- Plugins
-- ============================================================================

require("lazy").setup({
  -- Colorscheme
  {
    "akinsho/horizon.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("horizon")
    end,
  },

  -- Telescope + FZF
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",

      -- Native FZF sorter (fast)
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        defaults = {
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })

      -- Enable FZF
      telescope.load_extension("fzf")
    end,
  },

  -- Multicursor
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
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },
    -- LSP support
  {
  "neovim/nvim-lspconfig",
  config = function()
    -- Define clangd using the new Neovim 0.11+ API
    vim.lsp.config("clangd", {
      cmd = { "clangd" },
      filetypes = { "c", "cpp", "objc", "objcpp" },
      root_markers = {
        "compile_commands.json",
        "compile_flags.txt",
        ".git",
      },
    })

    -- Enable it
    vim.lsp.enable("clangd")
  end,
},
{
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- treesitter (safe even if not installed)
    })
  end,
},
})

-- ============================================================================
-- Keymaps
-- ============================================================================

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa!<cr>", { desc = "Quit Neovim" })

vim.keymap.set("n", "<M-m>", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<M-i>", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file tree" })

-- Alt+o to move to the next window
vim.keymap.set("n", "<M-o>", "<C-w>w", { desc = "Cycle through windows" })

-- require("config.lazy")
-- bootstrap lazy.nvim, LazyVim and your plugins
-- after: colorscheme horizon
vim.api.nvim_set_hl(0, "Normal",      { bg = "#262f33" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#262f33" })
vim.api.nvim_set_hl(0, "SignColumn",  { bg = "#262f33" })
--vim.api.nvim_set_hl(0, "LineNr",      { bg = "#262f33" })
-- change current highligth color
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2b2f38" })
-- Make line numbers dimmer
vim.api.nvim_set_hl(0, "LineNr",        { fg = "#444444" })   -- dim grey
vim.o.guicursor = table.concat({
"n-v-c:block-blinkwait700-blinkon400-blinkoff400",
"i-ci:ver25-blinkwait700-blinkon300-blinkoff300",
"r:hor20-blinkwait700-blinkon300-blinkoff300",
}, ",")

-- remove the vertical split line
vim.o.fillchars = "vert: "
vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE", fg = "NONE" })

-- Vertical split: Alt+v + p
vim.keymap.set("n", "vp", ":vsplit<CR>", { desc = "Vertical split" })

-- Horizontal split: Alt+s + p
vim.keymap.set("n", "sp", ":split<CR>", { desc = "Horizontal split" })

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Emacs-style window management
map("n", "<C-x>0", "<C-w>c", opts)  -- delete current window
map("n", "<C-x>1", "<C-w>o", opts)  -- delete other windows (only current remains)

-- movement
map("n", "gl", "$", opts)      -- go to end of line
map("n", "gh", "0", opts)      -- go to beginning of line
map("n", "qq", ":exit<CR>", opts)

-- buffer control
map("n", "gn", ":bnext<CR>", opts)     -- next buffer
map("n", "gp", ":bprevious<CR>", opts) -- previous buffer
map("n", "ge", "G", opts)              -- go to end of buffer
map("n", "mm", "%", opts)
map("n", "md", "d%", opts)

-- save file
map("n", "vv", ":w<CR>", opts)   -- save (basic-save-buffer)

-- Emacs-style window 
map("n", "<C-x>0", "<C-w>c", opts)  -- delete current window
map("n", "<C-x>1", "<C-w>o", opts)  -- delete other windows (only current remains)

-- SPC SPC → find files
vim.keymap.set("n", "<leader><leader>", builtin.find_files, {
  desc = "Find files",
})

-- SPC b b → buffers
vim.keymap.set("n", "<leader>bb", builtin.buffers, {
  desc = "List buffers",
})


-- =========================
-- LSP keymaps
-- =========================

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

vim.keymap.set("n", "<C-o>", function()
  local file = vim.fn.expand("%:t")
  local base = vim.fn.expand("%:r")
  local dir = vim.fn.expand("%:h")

  local candidates = {
    base .. ".cpp",
    base .. ".cc",
    base .. ".c",
    base .. ".cxx",
    base .. ".hpp",
    base .. ".hh",
    base .. ".h",
  }

  for _, target in ipairs(candidates) do
    local full = dir .. "/" .. target
    if full ~= vim.fn.expand("%:p") and vim.fn.filereadable(full) == 1 then
      vim.cmd("edit " .. full)
      return
    end
  end

  print("No matching header/source found")
end, { desc = "Toggle between header/source" })
