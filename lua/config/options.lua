vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.autoread = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = ""
vim.opt.cursorline = true
vim.opt.foldenable = false
vim.opt.timeoutlen = 200

vim.api.nvim_create_autocmd("TermEnter", {
  callback = function() vim.opt.cursorline = false end,
})
vim.api.nvim_create_autocmd("TermLeave", {
  callback = function() vim.opt.cursorline = true end,
})
