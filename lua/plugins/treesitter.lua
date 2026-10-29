return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "python", "lua", "rust", "javascript", "typescript",
        "zig", "julia", "html", "json", "yaml", "toml",
        "markdown", "markdown_inline", "bash", "vim",
        "r", "rnoweb", "latex", "csv",
      },
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
      indent    = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      -- nvim 0.12 passes capture lists to directives; the frozen master branch expects single nodes,
      -- which crashes markdown code-fence injections. Re-register the two affected directives.
      require("nvim-treesitter.query_predicates")
      local function last(nodes) return type(nodes) == "table" and nodes[#nodes] or nodes end
      vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
        local node = last(match[pred[2]])
        if not node then return end
        local alias = vim.treesitter.get_node_text(node, bufnr):lower()
        metadata["injection.language"] = vim.treesitter.language.get_lang(alias) or alias
      end, { force = true, all = true })
      vim.treesitter.query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
        local id = pred[2]
        local node = last(match[id])
        if not node then return end
        metadata[id] = metadata[id] or {}
        metadata[id].text = string.lower(vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[id] }) or "")
      end, { force = true, all = true })
    end,
  },
}
