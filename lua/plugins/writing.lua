return {
  -- Zen mode
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    opts = {
      window = {
        width = 90,
        options = {
          signcolumn    = "no",
          number        = false,
          relativenumber = false,
          cursorline    = false,
        },
      },
      plugins = {
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux     = { enabled = false },
      },
      on_open = function()
        vim.api.nvim_set_hl(0, "Normal",      { bg = "#0d0d14" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0d0d14" })
      end,
      on_close = function()
        vim.api.nvim_set_hl(0, "Normal",      { bg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      end,
    },
  },

  -- Twilight (dims inactive code)
  {
    "folke/twilight.nvim",
    config = function(_, opts)
      require("twilight").setup(opts)
      -- Force tree parse so scope expansion doesn't collapse to current line
      local view = require("twilight.view")
      local original_get_node = view.get_node
      view.get_node = function(buf, line)
        local ok, parser = pcall(vim.treesitter.get_parser, buf)
        if ok and parser and parser.parse then
          pcall(function() parser:parse() end)
        end
        return original_get_node(buf, line)
      end
    end,
    opts = {
      dimming  = { alpha = 0.35 },
      context  = 15,
      treesitter = true,
      expand = {
        "function", "method", "table", "if_statement",
        "function_definition", "class_definition",
        "function_declaration", "method_definition", "arrow_function", "class_declaration",
        "function_item", "impl_item", "struct_item",
        "fn_decl",
        "for_statement", "while_statement",
      },
    },
  },

  -- Rendered markdown (on by default only in the grind problem viewer; :RenderMarkdown toggle elsewhere)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    lazy = vim.env.GRIND_VIEW == nil,
    opts = {
      enabled = vim.env.GRIND_VIEW ~= nil,
      render_modes = true,
      heading = { width = "block", left_pad = 1, right_pad = 3, border = true, border_virtual = true, sign = false },
      code = { width = "block", left_pad = 2, right_pad = 2, min_width = 56, border = "thin", sign = false },
      bullet = { icons = { "•", "◦", "▸", "▹" } },
      pipe_table = { style = "full" },
      anti_conceal = { enabled = false },  -- read-only views: keep the line under the cursor rendered too
    },
  },
}
