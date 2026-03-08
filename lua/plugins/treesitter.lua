return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "python", "lua", "rust", "javascript", "typescript",
        "zig", "julia", "html", "json", "yaml", "toml",
        "markdown", "markdown_inline", "bash",
      },
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
      indent    = { enable = true },
    },
  },
}
