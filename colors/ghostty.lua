-- Ghostty-inspired colorscheme for Neovim
-- Matches the Ghostty terminal configuration

local colors = {
  bg = "#00031D",
  fg = "#d1d1d1",
  cursor = "#9d9d9d",
  cursor_text = "#1d1e1d",
  selection_bg = "#3f638a",
  selection_fg = "#ffffff",
  -- ANSI palette
  black = "#000000",
  red = "#c65339",
  green = "#6ac44b",
  yellow = "#b8b74a",
  blue = "#6444ed",
  magenta = "#d357db",
  cyan = "#69c1cf",
  white = "#d1d1d1",
  bright_black = "#909090",
  bright_red = "#eb5a3a",
  bright_green = "#77ea51",
  bright_yellow = "#efef53",
  bright_blue = "#d09af9",
  bright_magenta = "#eb5af7",
  bright_cyan = "#78f1f2",
  bright_white = "#ededed",
}

vim.g.colors_name = "ghostty"

-- Reset highlighting
vim.cmd("hi clear")

-- Basic highlights
vim.api.nvim_set_hl(0, "Normal", { fg = colors.fg, bg = colors.bg })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.fg, bg = colors.bg })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.bright_black, bg = colors.bg })

-- Cursor
vim.api.nvim_set_hl(0, "Cursor", { fg = colors.cursor_text, bg = colors.cursor })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#0a0a2e" })
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#0a0a2e" })

-- Selection
vim.api.nvim_set_hl(0, "Visual", { fg = colors.selection_fg, bg = colors.selection_bg })
vim.api.nvim_set_hl(0, "VisualNOS", { fg = colors.selection_fg, bg = colors.selection_bg })

-- Search
vim.api.nvim_set_hl(0, "Search", { fg = colors.black, bg = colors.bright_yellow })
vim.api.nvim_set_hl(0, "IncSearch", { fg = colors.black, bg = colors.bright_yellow })

-- UI
vim.api.nvim_set_hl(0, "LineNr", { fg = colors.bright_black })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.bright_white, bold = true })
vim.api.nvim_set_hl(0, "SignColumn", { bg = colors.bg })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#0a0a2e" })
vim.api.nvim_set_hl(0, "VertSplit", { fg = colors.bright_black })

-- Status line
vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.white, bg = "#0a0a2e" })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.bright_black, bg = "#0a0a2e" })

-- Messages
vim.api.nvim_set_hl(0, "MsgArea", { fg = colors.fg })
vim.api.nvim_set_hl(0, "MsgSeparator", { fg = colors.bright_black, bg = colors.bg })

-- Syntax highlighting
vim.api.nvim_set_hl(0, "Comment", { fg = colors.bright_black, italic = true })
vim.api.nvim_set_hl(0, "String", { fg = colors.bright_green })
vim.api.nvim_set_hl(0, "Number", { fg = colors.bright_magenta })
vim.api.nvim_set_hl(0, "Boolean", { fg = colors.bright_magenta })
vim.api.nvim_set_hl(0, "Identifier", { fg = colors.bright_cyan })
vim.api.nvim_set_hl(0, "Function", { fg = colors.bright_blue })
vim.api.nvim_set_hl(0, "Keyword", { fg = colors.bright_magenta })
vim.api.nvim_set_hl(0, "Statement", { fg = colors.bright_magenta })
vim.api.nvim_set_hl(0, "Type", { fg = colors.bright_blue })
vim.api.nvim_set_hl(0, "Operator", { fg = colors.bright_cyan })
vim.api.nvim_set_hl(0, "Special", { fg = colors.bright_red })
vim.api.nvim_set_hl(0, "Constant", { fg = colors.bright_magenta })

-- Diagnostics
vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.bright_red })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.bright_yellow })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.bright_cyan })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.bright_blue })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = colors.bright_red })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = colors.bright_yellow })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = colors.bright_cyan })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = colors.bright_blue })

-- Tree-sitter
vim.api.nvim_set_hl(0, "@variable", { link = "Identifier" })
vim.api.nvim_set_hl(0, "@function", { link = "Function" })
vim.api.nvim_set_hl(0, "@function.call", { link = "Function" })
vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
vim.api.nvim_set_hl(0, "@string", { link = "String" })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
vim.api.nvim_set_hl(0, "@type", { link = "Type" })
vim.api.nvim_set_hl(0, "@number", { link = "Number" })
vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })

-- Diff
vim.api.nvim_set_hl(0, "DiffAdd", { fg = colors.bright_green, bg = "#0a2a0a" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = colors.bright_red, bg = "#2a0a0a" })
vim.api.nvim_set_hl(0, "DiffChange", { fg = colors.bright_yellow, bg = "#2a2a0a" })
vim.api.nvim_set_hl(0, "DiffText", { fg = colors.bright_yellow, bg = "#2a2a10" })
