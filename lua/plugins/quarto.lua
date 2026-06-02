return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = "curly",
        languages = { "python", "r", "bash", "html", "yaml", "json", "lua" },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = false,
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)

      vim.api.nvim_create_user_command("QuartoRender", function(command_opts)
        if vim.bo.filetype ~= "quarto" and vim.fn.expand("%:e") ~= "qmd" then
          vim.notify("QuartoRender expects a .qmd buffer", vim.log.levels.WARN)
          return
        end

        vim.cmd("write")

        local buffer_path = vim.api.nvim_buf_get_name(0)
        local project_file = vim.fs.find("_quarto.yml", {
          path = vim.fs.dirname(buffer_path),
          upward = true,
        })[1]

        local target = project_file and vim.fs.dirname(project_file) or buffer_path
        local extra_args = vim.trim(command_opts.args or "")
        local cmd = "quarto render " .. vim.fn.shellescape(target)

        if extra_args ~= "" then
          cmd = cmd .. " " .. extra_args
        end

        local current_tabpage = vim.api.nvim_get_current_tabpage()

        vim.cmd("tabnew")
        local term_buf = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_set_current_buf(term_buf)
        vim.bo[term_buf].buflisted = true

        vim.fn.termopen(cmd, {
          on_exit = function(_, code, _)
            vim.schedule(function()
              if code == 0 then
                vim.notify("Quarto render completed", vim.log.levels.INFO)
              else
                vim.notify("Quarto render failed with exit code " .. code, vim.log.levels.ERROR)
              end
            end)
          end,
        })

        vim.api.nvim_set_current_tabpage(current_tabpage)
      end, { nargs = "*" })
    end,
    keys = {
      {
        "<leader>qp",
        function()
          require("quarto").quartoPreview()
        end,
        desc = "Quarto Preview",
      },
      { "<leader>qa", "<cmd>QuartoActivate<cr>", desc = "Quarto Activate" },
      { "<leader>qr", "<cmd>QuartoRender<cr>", desc = "Quarto Render" },
    },
  },
}
