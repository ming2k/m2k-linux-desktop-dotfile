return {
  name = "clangd",
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm"
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = { ".git", "compile_commands.json", "compile_flags.txt", ".clangd" },
  single_file_support = true,
  settings = {
    clangd = {
      arguments = {
        "--header-insertion-decorators",
        "--suggest-missing-includes",
      },
    },
  },
  on_attach = function(client, bufnr)
    -- 在这里添加你想要的 on_attach 功能
    -- 例如，设置键映射，启用自动格式化等

    -- 启用 clangd 的内联提示
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.buf.inlay_hint(bufnr, true)
    end

    -- 设置一些有用的键映射
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, opts)
  end,
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  flags = {
    debounce_text_changes = 150,
  },
}
