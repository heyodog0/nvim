return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "Diagnostics" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>",                  desc = "Symbols" },
      { "<leader>cL", "<cmd>Trouble lsp toggle<cr>",                      desc = "LSP" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>",                 desc = "Quickfix" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>",                  desc = "Loclist" },
    },
  },
}
