return {
  {
    "R-nvim/R.nvim",
    ft = { "r", "rmd", "quarto", "rnoweb", "rhelp" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("r").setup({
        R_args = { "--quiet", "--no-save" },
        hook = {
          on_filetype = function()
            vim.keymap.set("n", "<leader>rf", function()
              require("r.run").start_R("R")
            end, {
              buffer = true,
              desc = "Start R",
            })
            vim.keymap.set("n", "<leader>rl", function()
              require("r.send").line()
            end, {
              buffer = true,
              desc = "Send line to R",
            })
            vim.keymap.set("n", "<leader>ra", function()
              require("r.send").source_file()
            end, {
              buffer = true,
              desc = "Send file to R",
            })
            vim.keymap.set("n", "<leader>rq", function()
              require("r.run").quit_R("nosave")
            end, {
              buffer = true,
              desc = "Quit R",
            })
            vim.keymap.set("v", "<leader>rs", function()
              require("r.send").selection()
            end, {
              buffer = true,
              desc = "Send selection to R",
            })
            vim.keymap.set("n", "<CR>", "<Plug>RDSendLine", {
              buffer = true,
              remap = true,
              desc = "Send current line to R",
            })
            vim.keymap.set("v", "<CR>", "<Plug>RSendSelection", {
              buffer = true,
              remap = true,
              desc = "Send selection to R",
            })
          end,
        },
      })
    end,
  },
}
