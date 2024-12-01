if true then
  return {}
end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    { "williamboman/mason.nvim" },
  },
  opts = {
    ---@type string[]
    ensure_installed = {
      "clangd",
      "rust_analyzer",
      "pyright",
      "gopls",
      "jdtls",        -- Java
      "ts_ls",        -- JS/TS
      "bashls",
      "lua_ls",
      "jsonls",
      "marksman",     -- Markdown
      "yamlls",
      "lemminx",      -- XML
      "sqlls",
      "dockerls",
      "vimls",
      "cmake",
    },
  },

  ---@type boolean
  automatic_installation = true,

  -- See `:h mason-lspconfig.setup_handlers()`
  ---@type table<string, fun(server_name: string)>?
  handlers = nil
}
