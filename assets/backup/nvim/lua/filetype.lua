-- Config behavior by filetypes

-- Set manual fold method for txt and conf files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "text", "conf" },
    callback = function()
        vim.opt_local.foldmethod = "manual"
    end
})

-- config file type of gentoo portage config file
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {
    "/etc/portage/package.use",
    "/etc/portage/package.mask",
    "/etc/portage/package.unmask",
    "/etc/portage/package.accept_keywords",
    "/etc/portage/package.license",
    "/etc/portage/package.env",
    -- set for dir
    "/etc/portage/package.use/*",
    "/etc/portage/package.mask/*",
    "/etc/portage/package.unmask/*",
    "/etc/portage/package.accept_keywords/*",
    "/etc/portage/package.license/*",
    "/etc/portage/package.env/*"
  },
  callback = function()
    vim.bo.filetype = "conf"
  end
})

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  command = "setlocal ts=2 sts=2 sw=2 expandtab",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  command = "setlocal ts=2 sts=2 sw=2 expandtab",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  command = "setlocal ts=4 sts=4 sw=4 expandtab",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "jsx", "tsx" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ebuild",
  command = "setlocal ts=4 sts=4 sw=4 expandtab",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal wrap linebreak",
})
