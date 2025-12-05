-- ~/.config/nvim/lua/plugins/lsp.lua

-- Ensure nvim-cmp capabilities (optional, but recommended for completion)
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok then
  vim.notify("cmp_nvim_lsp not found!", vim.log.levels.WARN)
  return
end

local capabilities = cmp_nvim_lsp.default_capabilities()

-- LSP setup
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then
  vim.notify("nvim-lspconfig not found!", vim.log.levels.WARN)
  return
end

-- Lua LSP
lspconfig.lua_ls.setup({
  capabilities = capabilities,
})

-- Python LSP
lspconfig.pyright.setup({
  capabilities = capabilities,
})

-- TypeScript / JavaScript LSP
lspconfig.tsserver.setup({
  capabilities = capabilities,
})

-- C / C++ LSP
lspconfig.clangd.setup({
  cmd = { "clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git") or vim.loop.cwd(),
  capabilities = capabilities,
})

