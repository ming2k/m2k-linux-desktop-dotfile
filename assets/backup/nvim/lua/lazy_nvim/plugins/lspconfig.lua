if true then
  return {}
end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim" },
  },
  config = function()
    local mason_registry = require("mason-registry")
    local lspconfig = require('lspconfig')
    local lsp_mappers = {
      { name = "lua_ls",        config_name = "lua_ls",        package_names = {"lua-language-server"} },
      { name = "clangd",        config_name = "clangd",        package_names = {"clangd"} },
      { name = "rust_analyzer", config_name = "rust_analyzer", package_names = {"rust-analyzer"} },
      { name = "gopls",         config_name = "gopls",         package_names = {"gopls"} },
      { name = "yamlls",        config_name = "yamlls",        package_names = {"yaml-language-server"} },
      { name = "html",          config_name = "html",          package_names = {"html-lsp"} },
      { name = "cssls",         config_name = "cssls",         package_names = {"css-lsp"} },
      { name = "eslint",        config_name = "eslint",        package_names = {"eslint-lsp"} },
      { name = "ts_ls",      config_name = "ts_ls",      package_names = {"typescript-language-server"} },
      { name = "efm",           config_name = "efm",           package_names = {"efm","prettier"} },
    }

    mason_registry.refresh(function()
      for _, mapper in ipairs(lsp_mappers) do
        local all_installed = true
        for _, package_name in ipairs(mapper.package_names) do
          local package = mason_registry.get_package(package_name)
          if not package:is_installed() then
            all_installed = false
            print("Package " .. package_name .. " is not installed for " .. mapper.name)
            break
          end
        end
        if all_installed then
          local config = require('lsp_configurations.' .. mapper.config_name)
          lspconfig[mapper.name].setup(config)
        else
          print("Not all required packages are installed for " .. mapper.name)
        end
      end
    end)
  end
}
