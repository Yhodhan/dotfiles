local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- NEW LSP API (Neovim 0.11+)
local lsp = vim.lsp

-- Lua LSP
lsp.config("lua_ls", {
  capabilities = capabilities,
})

-- Python LSP
lsp.config("pyright", {
  capabilities = capabilities,
})

-- TypeScript / JavaScript  
-- (tsserver is the correct name)
lsp.config("tsserver", {
  capabilities = capabilities,
})

-- C / C++ LSP
lsp.config("clangd", {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = function(fname)
    return vim.fs.root(fname, { "compile_commands.json", ".git" })
  end,
})

