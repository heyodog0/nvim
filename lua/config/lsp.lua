vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD",         vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K",          vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi",         vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>",      vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
    vim.keymap.set("n", "<leader>D",  vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr",         "<cmd>Telescope lsp_references<cr>", opts)
    vim.keymap.set("n", "<leader>e",  vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d",         vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<leader>q",  vim.diagnostic.setloclist, opts)
  end,
})

vim.lsp.config.ruff = {}
vim.lsp.config.rust_analyzer = {}
vim.lsp.config.lua_ls = {}
vim.lsp.config.pyright = {}
vim.lsp.config.gopls = {}
vim.lsp.config.ts_ls = {}
vim.lsp.config.jsonls = {}
vim.lsp.config.yamlls = {}

vim.lsp.enable("ruff")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("gopls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("jsonls")
vim.lsp.enable("yamlls")
