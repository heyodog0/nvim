return {
  -- Noice (cmdline popup and notifications)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      cmdline = {
        view = "cmdline_popup",
        format = {
          cmdline    = { icon = ":", lang = "vim" },
          search_down = { icon = "/", lang = "regex" },
          search_up  = { icon = "?", lang = "regex" },
        },
      },
      views = {
        cmdline_popup = {
          position = { row = "100%", col = "50%" },
          size = { width = 60, height = "auto" },
        },
      },
      messages = { view = "notify" },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        { filter = { event = "msg_show", kind = "", find = "written" }, opts = { skip = true } },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },

  -- Lualine (statusline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  -- Bufferline (buffer tabs)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        close_command = "bdelete! %d",
        diagnostics = "nvim_lsp",
        separator_style = "thin",
      },
    },
  },

  -- Dressing (better UI dialogs)
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Illuminate (highlight references)
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
  },

  -- Smear cursor
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      smear_between_buffers = false,
      smear_between_neighbor_lines = false,
      scroll_buffer_space = false,
      legacy_computing_symbols_support = true,
      smear_insert_mode = false,
      time_interval = 5,
      damping = 0.9,
    },
  },
}
