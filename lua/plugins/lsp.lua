return {
  { "williamboman/mason.nvim",           cmd = "Mason", opts = {} },
  { "williamboman/mason-lspconfig.nvim", opts = {} },

  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          python     = { "ruff_format", "ruff_fix" },
          rust       = { "rustfmt" },
          lua        = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json       = { "jq" },
          yaml       = { "yamlfix" },
        },
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          if vim.bo.buftype ~= "terminal" then
            require("conform").format({ bufnr = args.buf })
          end
        end,
      })
    end,
  },
}
