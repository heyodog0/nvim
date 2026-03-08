return {
  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Indent blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- Comment.nvim
  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  -- Mini (ai, surround, pairs)
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup()
      require("mini.surround").setup()
      require("mini.pairs").setup()
    end,
  },

  -- Flash (enhanced motions)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,            desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,      desc = "Flash Treesitter" },
      { "r", mode = "o",               function() require("flash").remote() end,           desc = "Remote Flash" },
    },
  },
}
