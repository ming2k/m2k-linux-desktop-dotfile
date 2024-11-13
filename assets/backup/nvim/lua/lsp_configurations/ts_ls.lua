-- lsp_configurations/ts_ls.lua

return {
  name = "ts_ls",
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = {},
  init_options = {
    hostInfo = "neovim",
  }
}
