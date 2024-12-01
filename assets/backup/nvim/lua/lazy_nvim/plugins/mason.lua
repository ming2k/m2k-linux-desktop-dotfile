-- if true then
--   return {}
-- end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "williamboman/mason.nvim",
  config = function()
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
      registry = {
        -- set refresh time to 7 days (unit second)
        frequency = 7 * 24 * 60 * 60,
      },
    })

    local mason_registry = require("mason-registry")

    -- Encapsulate installation process
    local function install(package_name)
      if package_name then
        local package = mason_registry.get_package(package_name)
        if not package:is_installed() then
          vim.notify("Installing " .. package_name, vim.log.levels.INFO)
          package:install()
        end
      else
        vim.notify("Unknown package: " .. package_name, vim.log.levels.ERROR)
      end
    end

    mason_registry.refresh(function()
      -- lsp
      install('lua-language-server')
      -- install("clangd")
      -- install('pyright')
      -- install('rust-analyzer')
      -- install("gopls")
      -- install("html-lsp")
      -- install("css-lsp")
      -- install('stylelint-lsp') -- css lint lsp
      -- install("typescript-language-server") -- JS/TS lsp
      -- install("eslint-lsp")
      -- install('json-lsp')
      -- install("yaml-language-server")
      -- install('sqlls')
      -- install('efm')
      -- install('prettier')
    end) -- refresh mason registry list

    require("lsp")
  end
}
